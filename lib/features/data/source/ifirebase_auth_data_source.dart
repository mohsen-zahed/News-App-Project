import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuthDataSource {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> loginWithEmailAndPassword(String email, String password);
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password);
  Future<UserCredential> signInAnonymously();
}

class FirebaseDataSourceImp implements IFirebaseAuthDataSource {
  final FirebaseAuth auth;

  FirebaseDataSourceImp({required this.auth});

  @override
  Future<UserCredential> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  Future<UserCredential> signInAnonymously() async {
    final UserCredential userCredential = await auth.signInAnonymously();
    return userCredential;
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}
