import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonarRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  DonarRepository({
    FirebaseFirestore? firebasefirestore,
    FirebaseAuth? firebaseAuth,
  })  : _firebaseFirestore = firebasefirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // Get a list of donors
  Future<Map<String, dynamic>> getDonors() async {
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('users')
        .where('role', isEqualTo: 'donor')
        .get();

    Map<String, dynamic> donors = {};
    for (var doc in querySnapshot.docs) {
      donors[doc.id] = doc.data();
    }

    return donors;
  }

  Future<Map<String, dynamic>> searchDonorsByBloodType(String bloodType) async {
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('users')
        .where('role', isEqualTo: 'donor') // Filter by role
        .where('bloodType', isEqualTo: bloodType) // Filter by blood type
        .get();

    Map<String, dynamic> donors = {};
    for (var doc in querySnapshot.docs) {
      donors[doc.id] = doc.data();
    }

    return donors;
  }

  Future<void> updateUserRoleToDonor(String uid) async {
    // Reference to the user's document
    DocumentReference userDoc = _firebaseFirestore.collection('users').doc(uid);

    // Update the role to 'donor'
    await userDoc.update({
      'role': 'donor', // Update the role field
    });
  }

  Future<DocumentSnapshot> fetchUserRole(String uid) async {
    // Reference to the user's document
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc;
  }

  Future<void> updateUserRoleToPatient(String uid) async {
    // Reference to the user's document
    DocumentReference userDoc = _firebaseFirestore.collection('users').doc(uid);

    // Update the role to 'donor'
    await userDoc.update({
      'role': 'patient', // Update the role field
    });
  }

// Stream<Map<String, dynamic>> streamDonors() {
  //   return _firebaseFirestore
  //       .collection('users')
  //       .where('role', isEqualTo: 'donor')
  //       .snapshots()
  //       .map((querySnapshot) {
  //     Map<String, dynamic> donors = {};
  //     for (var doc in querySnapshot.docs) {
  //       donors[doc.id] = doc.data();
  //     }
  //     return donors;
  //   });
  // }

  // Update the user's role from 'patient' to 'donor'
}
