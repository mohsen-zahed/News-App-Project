import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/data/source/ifirebase_auth_data_source.dart';
import 'package:news_app/packages/firebase_auth_package/firebase_auth_constants.dart';

final firebaseAuthRepository = FirebaseAuthRepositoryImp(iFirebaseAuthDataSource: FirebaseDataSourceImp(auth: auth));

abstract class IFirebaseAuthRepository extends IFirebaseAuthDataSource {}

final class FirebaseAuthRepositoryImp implements IFirebaseAuthRepository {
  final IFirebaseAuthDataSource iFirebaseAuthDataSource;

  FirebaseAuthRepositoryImp({required this.iFirebaseAuthDataSource});
  @override
  Future<UserCredential> signInAnonymously() => iFirebaseAuthDataSource.signInAnonymously();

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) =>
      iFirebaseAuthDataSource.signInWithEmailAndPassword(email, password);

  @override
  Future<UserCredential> signInWithGoogle() => iFirebaseAuthDataSource.signInWithGoogle();

  @override
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) =>
      iFirebaseAuthDataSource.signUpWithEmailAndPassword(email, password);
}
