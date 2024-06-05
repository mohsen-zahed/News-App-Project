import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/firebase_firestore_package/firebase_firestore_package.dart';
import 'package:news_app/packages/image_picker_package/image_picker_package.dart';

abstract class IFirebaseUserInfoDataSource {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signUpWithGoogle();
  Future<UserCredential> loginWithEmailAndPassword(String email, String password);
  Future<UserCredential> signUpWithEmailAndPassword(String name, String email, String password);
  Future<UserCredential> signInAnonymously();
  Future<void> sendForgotPasswordLink(String email);
  Future<dynamic> getUserInfoFromFirebase(String uid);
  Future<User?> getCurrentUser(UserCredential userCredential);
  Future<void> signOutUser();
  Future<String> updateUserImage(String name, String userId);
  Future<void> storeToUserSavedList(String userId, String id);
  Future<void> removeFromUserSavedList(String userId, String id);
}

class FirebaseUserInfoDataSourceImp implements IFirebaseUserInfoDataSource {
  final FirebaseAuth auth;
  final MyFirebaseFirestorePackage myFirestore;
  final MyImagePickerPackage myImagePicker;

  FirebaseUserInfoDataSourceImp({required this.myFirestore, required this.auth, required this.myImagePicker});

  @override
  Future<UserCredential> signInWithGoogle() async {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signUpWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  Future<UserCredential> signInAnonymously() async {
    var formattedDate = getFormattedChristianDate();
    final UserCredential userCredential = await auth.signInAnonymously();
    final userId = userCredential.user!.uid;
    await MyFirebaseFirestorePackage.instance.storeUserInfoToFirebase(userId, 'Anonymous', 'Anonymous', '--', formattedDate, []);
    return userCredential;
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(String name, String email, String password) async {
    var formattedDate = getFormattedChristianDate();
    final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final userId = userCredential.user!.uid;
    await MyFirebaseFirestorePackage.instance.storeUserInfoToFirebase(userId, name, email, password, formattedDate, []);
    return userCredential;
  }

  @override
  Future<void> sendForgotPasswordLink(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<dynamic> getUserInfoFromFirebase(String uid) async {
    final result = await MyFirebaseFirestorePackage.instance.getUserInfoFromFirebase('users', uid);
    return result;
  }

  @override
  Future<User?> getCurrentUser(UserCredential userCredential) async {
    return userCredential.user;
  }

  @override
  Future<void> signOutUser() async {
    await auth.signOut();
  }

  @override
  Future<String> updateUserImage(String name, String id) async {
    final imageUrl = await myImagePicker.pickUserImageFromGallery(name, id);
    return imageUrl;
  }

  @override
  Future<void> storeToUserSavedList(String userId, String id) async {
    await myFirestore.storeToUserSavedList(userId, id);
  }

  @override
  Future<void> removeFromUserSavedList(String userId, String id) async {
    await myFirestore.removeFromUserSavedList(userId, id);
  }
}
