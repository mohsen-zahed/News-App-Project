import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/data/source/ifirebase_auth_data_source.dart';
import 'package:news_app/packages/firebase_auth_package/firebase_auth_constants.dart';
import 'package:news_app/packages/firebase_firestore_package/firebase_firestore_constants.dart';

final firebaseAuthRepository = FirebaseAuthRepositoryImp(iFirebaseAuthDataSource: FirebaseDataSourceImp(auth: auth, firestore: cloudFirestore));

abstract class IFirebaseAuthRepository {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> loginWithEmailAndPassword(String email, String password);
  Future<UserCredential> signUpWithEmailAndPassword(String name, String email, String password);
  Future<UserCredential> signInAnonymously();
  Future<void> sendForgotPasswordLink(String email);
}

final class FirebaseAuthRepositoryImp implements IFirebaseAuthRepository {
  final IFirebaseAuthDataSource iFirebaseAuthDataSource;

  FirebaseAuthRepositoryImp({required this.iFirebaseAuthDataSource});
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
}
