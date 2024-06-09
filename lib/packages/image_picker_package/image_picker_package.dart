import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:news_app/packages/firebase_firestore_package/firebase_firestore_package.dart';
import 'package:news_app/packages/firebase_storage_package/firebase_storage_package.dart';

class MyImagePickerPackage {
  static MyImagePickerPackage? _instance;
  MyImagePickerPackage._();
  static MyImagePickerPackage get instance {
    _instance ??= MyImagePickerPackage._();
    return _instance!;
  }

  Future<String> pickUserImageFromGallery(String userName, dynamic uid, String previousImageUrl) async {
    ImagePicker picker = ImagePicker();
    var editPickedProfileImage = await picker.pickImage(source: ImageSource.gallery);
    var pickedImageFile = File(editPickedProfileImage?.path ?? '');
    if (editPickedProfileImage != null) {
      final ref = await MyFirebaseStoragePackage.instance.createFolderWithChild(folderName: 'usersImage', userName: userName);
      await ref!.putFile(pickedImageFile);
      final imageDownloadLink = await ref.getDownloadURL();
      MyFirebaseFirestorePackage.instance.updateUserImageInFirebase(uid, imageDownloadLink);
      return imageDownloadLink;
    }
    return previousImageUrl;
  }
}
