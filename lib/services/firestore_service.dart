import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mywater_web_app/models/auth_model.dart';
import 'package:mywater_web_app/models/scan_model.dart';

class FirestoreService {
  FirestoreService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// add user scan
  static Future<void> addScan({required String userEmail, required ScanModel scan}) {
    return _firestore.collection('appdata').doc(userEmail).collection('scans').doc(scan.scanCodeId).set(scan.toMap());
  }

  /// get user scans
  static getUserScans({required String userEmail}) => _firestore.collection('/appdata/$userEmail/scans/').withConverter<ScanModel>(fromFirestore: (snapshots, _) => ScanModel.fromJson(jsonEncode(snapshots.data())), toFirestore: (scan, _) => scan.toMap());

  /// add user data
  static Future<void> addUser({required String userEmail, required AuthModel user}) {
    return _firestore.collection('users').doc(userEmail).set(user.toMap(), SetOptions(merge: true));
  }

  /// retrieve authData
  static Stream<DocumentSnapshot<AuthModel>> getUserAuthData({required String userEmail}) {
    return _firestore.collection('users').doc(userEmail).withConverter<AuthModel>(fromFirestore: (snapshot, _) => AuthModel.fromJson(jsonEncode(snapshot.data())), toFirestore: (auth, _) => auth.toMap()).snapshots();
  }

  static Future<bool> checkIfUserExists(String userPhone) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(userPhone).get();

      return snapshot.exists;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkIfUserScanExits(String scanId, String userEmail) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('appdata/$userEmail/scans').doc(scanId).get();

      return snapshot.exists;
    } catch (e) {
      return false;
    }
  }
}
