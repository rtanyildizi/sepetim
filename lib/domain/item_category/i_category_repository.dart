import 'dart:io';
import 'package:Sepetim/domain/core/enums.dart';
import 'package:Sepetim/domain/core/value_objects.dart';
import 'package:Sepetim/domain/item_category/item_category.dart';
import 'package:Sepetim/domain/item_category/item_category_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kt_dart/kt.dart';

abstract class IItemCategoryRepository {
  Future<Either<ItemCategoryFailure, Unit>> create(
    ItemCategory category,
  );
  Future<Either<ItemCategoryFailure, Unit>> update(
    ItemCategory category,
  );
  Future<Either<ItemCategoryFailure, Unit>> delete(
    ItemCategory category,
  );

  Future<Either<ItemCategoryFailure, File>> loadCoverPictureFromDevice(
    ImageSource imageSource,
  );
  Future<Either<ItemCategoryFailure, ImageUrl>> loadCoverPictureToServer(
    ItemCategory category,
    File imageFile,
  );
  Future<Either<ItemCategoryFailure, ImageUrl>> removeCoverPictureFromServer(
    ItemCategory category,
  );

  Stream<Either<ItemCategoryFailure, KtList<ItemCategory>>> watchAll(
    OrderType orderType,
  );
  Stream<Either<ItemCategoryFailure, KtList<ItemCategory>>> watchAllByTitle(
    OrderType orderType,
    String title,
  );
}
