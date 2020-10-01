import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

import 'package:Sepetim/domain/core/enums.dart';
import 'package:Sepetim/domain/core/value_objects.dart';
import 'package:Sepetim/domain/item/i_item_repository.dart';
import 'package:Sepetim/domain/item_group/i_group_repository.dart';
import 'package:Sepetim/domain/item_group/item_group.dart';
import 'package:Sepetim/domain/item_group/item_group_failure.dart';
import 'package:Sepetim/infrastructure/core/firebase_helpers.dart';
import 'package:Sepetim/infrastructure/item/item_dtos.dart';
import 'package:Sepetim/infrastructure/item_group/item_group_dtos.dart';

@LazySingleton(as: IItemGroupRepository)
class ItemGroupRepository implements IItemGroupRepository {
  final FirebaseFirestore _firestore;
  final IItemRepository _itemRepository;

  ItemGroupRepository(
    this._firestore,
    this._itemRepository,
  );

  @override
  Future<Either<ItemGroupFailure, Unit>> create(
      UniqueId categoryId, ItemGroup group) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        return left(const ItemGroupFailure.networkException());
      }

      final userDoc = await _firestore.userDocument();
      final categoryDoc =
          userDoc.categoryCollection.doc(categoryId.getOrCrash());

      final groupDto = ItemGroupDto.fromDomain(group);

      await categoryDoc.groupCollection
          .doc(groupDto.uid)
          .set(groupDto.toJson());

      final increaseGroupCountFunc = CloudFunctions.instance
          .getHttpsCallable(functionName: 'increaseGroupCount');

      final result = await increaseGroupCountFunc.call(<String, Object>{
        'userId': userDoc.id,
        'categoryId': categoryId.getOrCrash(),
        'operation': 'increase',
      });

      if (result != null &&
          result.data != null &&
          result.data["type"] == "success") {
        return right(unit);
      } else {
        throw PlatformException(
            code: "FUNCTIONS_ERROR",
            message:
                "Error occured when cloud function running. Invalid result returned");
      }
    } on FirebaseAuthException catch (e) {
      if (e.message.contains('PERMISSION_DENIED')) {
        return left(const ItemGroupFailure.insufficientPermission());
      } else {
        return left(const ItemGroupFailure.unexpected());
      }
    } on PlatformException catch (_) {
      return left(const ItemGroupFailure.unexpected());
    }
  }

  @override
  Future<Either<ItemGroupFailure, Unit>> update(
      UniqueId categoryId, ItemGroup group) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        return left(const ItemGroupFailure.networkException());
      }

      final userDoc = await _firestore.userDocument();
      final categoryDoc =
          userDoc.categoryCollection.doc(categoryId.getOrCrash());

      final groupDto = ItemGroupDto.fromDomain(group);

      await categoryDoc.groupCollection
          .doc(groupDto.uid)
          .update(groupDto.toJson());
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.message.contains('PERMISSION_DENIED')) {
        return left(const ItemGroupFailure.insufficientPermission());
      } else if (e.message.contains('NOT_FOUND')) {
        return left(const ItemGroupFailure.unableToUpdate());
      } else {
        return left(const ItemGroupFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<ItemGroupFailure, Unit>> delete(
      UniqueId categoryId, ItemGroup group) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        return left(const ItemGroupFailure.networkException());
      }
      final groupId = group.uid;
      final userDoc = await _firestore.userDocument();

      final deleteItemFunction =
          CloudFunctions.instance.getHttpsCallable(functionName: "clearData");

      final result = await deleteItemFunction.call(<String, String>{
        "userId": userDoc.id,
        "categoryId": categoryId.getOrCrash(),
        "groupId": groupId.getOrCrash(),
      });

      if (result != null &&
          result.data != null &&
          result.data["type"] == "success") {
        return right(unit);
      } else {
        throw PlatformException(
          code: result.data["code"].toString(),
          message: "Error occured when cloud function running. Error was: " +
              result.data["message"].toString(),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.message.contains('PERMISSION_DENIED')) {
        return left(const ItemGroupFailure.insufficientPermission());
      } else if (e.message.contains('NOT_FOUND')) {
        return left(const ItemGroupFailure.unableToUpdate());
      } else {
        return left(const ItemGroupFailure.unexpected());
      }
    } on PlatformException catch (e) {
      if (e.code == "ERROR_INSUFFICIENT_PERMISSION") {
        return left(const ItemGroupFailure.insufficientPermission());
      } else {
        return left(const ItemGroupFailure.unexpected());
      }
    }
  }

  @override
  Stream<Either<ItemGroupFailure, KtList<ItemGroup>>> watchAll(
      UniqueId categoryId, OrderType orderType) async* {
    final userDoc = await _firestore.userDocument();
    final categoryDoc = userDoc.categoryCollection.doc(categoryId.getOrCrash());

    Stream<QuerySnapshot> orderedGroupSnapshots;

    switch (orderType) {
      case OrderType.date:
        {
          orderedGroupSnapshots = categoryDoc.groupCollection
              .orderBy('creationTime', descending: true)
              .snapshots();
          break;
        }
      case OrderType.title:
        {
          orderedGroupSnapshots =
              categoryDoc.groupCollection.orderBy('title').snapshots();
          break;
        }
      default:
        {
          orderedGroupSnapshots = categoryDoc.groupCollection.snapshots();
          break;
        }
    }

    yield* orderedGroupSnapshots
        .map((snapshot) => right<ItemGroupFailure, KtList<ItemGroup>>(snapshot
            .docs
            .map((doc) => ItemGroupDto.fromFirestore(doc).toDomain())
            .toImmutableList()))
        .onErrorReturnWith((e) {
      if (e is FirebaseAuthException &&
          e.message.contains('PERMISSION_DENIED')) {
        return left(const ItemGroupFailure.insufficientPermission());
      } else {
        return left(const ItemGroupFailure.unexpected());
      }
    });
  }

  @override
  Stream<Either<ItemGroupFailure, KtList<ItemGroup>>> watchAllByTitle(
    UniqueId categoryId,
    OrderType orderType,
    String title,
  ) async* {
    final userDoc = await _firestore.userDocument();
    final categoryDoc = userDoc.categoryCollection.doc(categoryId.getOrCrash());

    Stream<QuerySnapshot> orderedGroupSnapshots;

    switch (orderType) {
      case OrderType.date:
        {
          orderedGroupSnapshots = categoryDoc.groupCollection
              .orderBy('creationTime', descending: true)
              .snapshots();
          break;
        }
      case OrderType.title:
        {
          orderedGroupSnapshots =
              categoryDoc.groupCollection.orderBy('title').snapshots();
          break;
        }
      default:
        {
          orderedGroupSnapshots = categoryDoc.groupCollection.snapshots();
          break;
        }
    }

    yield* orderedGroupSnapshots
        .map((snapshot) => snapshot.docs
            .map((doc) => ItemGroupDto.fromFirestore(doc).toDomain()))
        .map((groups) => right<ItemGroupFailure, KtList<ItemGroup>>(groups
            .where((group) => group.title
                .getOrCrash()
                .toLowerCase()
                .startsWith(title.toLowerCase()))
            .toImmutableList()))
        .onErrorReturnWith((e) {
      if (e is FirebaseAuthException &&
          e.message.contains('PERMISSION_DENIED')) {
        return left(const ItemGroupFailure.insufficientPermission());
      } else {
        return left(const ItemGroupFailure.unexpected());
      }
    });
  }
}
