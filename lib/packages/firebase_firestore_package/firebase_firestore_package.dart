import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/packages/firebase_firestore_package/firebase_firestore_constants.dart';

class MyFirebaseFirestorePackage {
  static MyFirebaseFirestorePackage? _instance;
  MyFirebaseFirestorePackage._();
  static MyFirebaseFirestorePackage get instance {
    _instance ??= MyFirebaseFirestorePackage._();
    return _instance!;
  }

  Future<void> storeUserInfoToFirebase(
      String userId, String name, String email, String password, String formattedDate, List<dynamic> savedItems) async {
    try {
      await cloudFirestore.collection('users').doc(userId).set({
        'id': userId,
        'name': name,
        'email': email,
        'password': password,
        'joinedAt': formattedDate,
        'accountCreatedOn': Timestamp.now(),
        'profileImage': 'https://cdn4.iconfinder.com/data/icons/professions-2-2/151/56-1024.png',
        'savedNews': savedItems,
      });
    } on FirebaseException catch (_) {}
  }

  Future<DocumentSnapshot> getUserInfoFromFirebase(String collectionName, String userId) async {
    return await cloudFirestore.collection(collectionName).doc(userId).get();
  }

  Future<User?> getCurrentUserFromFirebase() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> updateUserImageInFirebase(String userId, String imageUrl) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'profileImage': imageUrl,
    });
  }

  Future<void> storeToUserSavedList(String userId, String newsId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'savedNews': FieldValue.arrayUnion([newsId]),
    });
  }

  Future<void> removeFromUserSavedList(String userId, String newsId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'savedNews': FieldValue.arrayRemove([newsId]),
    });
  }

  Future<dynamic> getSavedNewsListFromFirebase(String userId) async {
    final response = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return response.get('savedNews');
  }
}
