import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUserProfile({
    required String uid,
    required String email,
    required String displayName,
    required int birthYear,
    required String location,
  }) async {
    await usersRef.doc(uid).set({
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'birthYear': birthYear,
      'location': location,
      'preferences': {},
      'favorites': [],
      'responseHistory': [],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
