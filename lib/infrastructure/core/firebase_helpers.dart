import 'package:Sepetim/domain/auth/i_auth_facade.dart';
import 'package:Sepetim/domain/core/errors.dart';
import 'package:Sepetim/injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

extension FirestoreX on FirebaseFirestore {
  Future<String> userId() async {
    final userOption = await getIt<IAuthFacade>().getSignedUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return user.id.getOrCrash();
  }
}

extension FirstoreX on FirebaseFirestore {
  CollectionReference get categoryCollection =>
      FirebaseFirestore.instance.collection("categories");
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get groupCollection => collection('groups');
  CollectionReference get itemCollection => collection('items');
}

extension FirebaseStorageX on FirebaseStorage {
  Future<StorageReference> userStorage() async {
    final userOption = await getIt<IAuthFacade>().getSignedUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    return FirebaseStorage.instance
        .ref()
        .child('users')
        .child(user.id.getOrCrash());
  }
}

extension StorageReferenceX on StorageReference {
  StorageReference get categoryCovers => child('category_covers');
  StorageReference get imagePictures => child('item_pictures');
}
