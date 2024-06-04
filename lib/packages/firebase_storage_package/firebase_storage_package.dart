import 'package:firebase_storage/firebase_storage.dart';

class MyFirebaseStoragePackage {
  static MyFirebaseStoragePackage? _instance;
  MyFirebaseStoragePackage._();
  static MyFirebaseStoragePackage get instance {
    _instance ??= MyFirebaseStoragePackage._();
    return _instance!;
  }

  Future<Reference?> createFolderWithChild({required String folderName, required String userName}) async {
    final res = FirebaseStorage.instance.ref().child(folderName).child('${userName.toString().trim()}.jpeg');
    return res;
  }
}
