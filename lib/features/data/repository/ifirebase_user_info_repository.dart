import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/data/source/ifirebase_user_info_data_source.dart';
import 'package:news_app/packages/firebase_auth_package/firebase_auth_constants.dart';
import 'package:news_app/packages/firebase_firestore_package/firebase_firestore_package.dart';
import 'package:news_app/packages/image_picker_package/image_picker_package.dart';

final firebaseUserInfoRepository = FirebaseUserInfoRepositoryImp(
    iFirebaseAuthDataSource:
        FirebaseUserInfoDataSourceImp(auth: auth, myFirestore: MyFirebaseFirestorePackage.instance, myImagePicker: MyImagePickerPackage.instance));

abstract class IFirebaseUserInfoRepository extends IFirebaseUserInfoDataSource {}

final class FirebaseUserInfoRepositoryImp implements IFirebaseUserInfoRepository {
  final IFirebaseUserInfoDataSource iFirebaseAuthDataSource;

  FirebaseUserInfoRepositoryImp({required this.iFirebaseAuthDataSource});
  @override
  Future<UserCredential> signInAnonymously() => iFirebaseAuthDataSource.signInAnonymously();

  @override
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) =>
      iFirebaseAuthDataSource.loginWithEmailAndPassword(email, password);

  @override
  Future<UserCredential> signInWithGoogle() => iFirebaseAuthDataSource.signInWithGoogle();

  @override
  Future<UserCredential> signUpWithEmailAndPassword(String name, String email, String password) =>
      iFirebaseAuthDataSource.signUpWithEmailAndPassword(name, email, password);

  @override
  Future<void> sendForgotPasswordLink(String email) => iFirebaseAuthDataSource.sendForgotPasswordLink(email);

  @override
  Future<dynamic> getUserInfoFromFirebase(String uid) => iFirebaseAuthDataSource.getUserInfoFromFirebase(uid);

  @override
  Future<UserCredential> signUpWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<User?> getCurrentUser(UserCredential userCredential) => iFirebaseAuthDataSource.getCurrentUser(userCredential);

  @override
  Future<void> signOutUser() => iFirebaseAuthDataSource.signOutUser();

  @override
  Future<String> updateUserImage(String name, String id) => iFirebaseAuthDataSource.updateUserImage(name, id);

  @override
  Future<void> storeToUserSavedList(String userId, String id) => iFirebaseAuthDataSource.storeToUserSavedList(userId, id);

  @override
  Future<void> removeFromUserSavedList(String userId, String id) => iFirebaseAuthDataSource.removeFromUserSavedList(userId, id);

  @override
  Future getUserSavedList(String userId) => iFirebaseAuthDataSource.getUserSavedList(userId);
}
