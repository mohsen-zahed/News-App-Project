import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFirebaseAuthDataSource {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signUpWithGoogle();
  Future<UserCredential> loginWithEmailAndPassword(String email, String password);
  Future<UserCredential> signUpWithEmailAndPassword(String name, String email, String password);
  Future<UserCredential> signInAnonymously();
}

class FirebaseDataSourceImp implements IFirebaseAuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseDataSourceImp({required this.firestore, required this.auth});

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
    final UserCredential userCredential = await auth.signInAnonymously();
    return userCredential;
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(String name, String email, String password) async {
    var date = DateTime.now().toString();
    var dateStamp = DateTime.parse(date);
    var formattedDate = '${dateStamp.year}-${dateStamp.month}-${dateStamp.day}::${dateStamp.hour}-${dateStamp.minute}-${dateStamp.second}';
    final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final userId = userCredential.user?.uid;
    await firestore.collection('users').doc(userId).set({
      'id': userId,
      'name': name,
      'email': email,
      'password': password,
      'joinedAt': formattedDate,
      'accountCreatedOn': Timestamp.now(),
      'profileImage': 'https://www.svgrepo.com/download/227887/news-reporter.svg',
      'savedNews': [],
    });
    return userCredential;
  }
}
