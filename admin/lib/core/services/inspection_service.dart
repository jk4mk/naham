import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Result of starting an inspection request.
class InspectionRequestResult {
  final String channelName;
  final String chefId;
  final String? chefName;

  const InspectionRequestResult({
    required this.channelName,
    required this.chefId,
    this.chefName,
  });
}

/// Firestore paths (match TC):
/// - chefs/{chefId} — isOnline, strikeCount, frozenUntil
/// - chefs/{chefId}/inspection_requests/current — channelName, status: pending | accepted | rejected
class InspectionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String _chefsCollection = 'chefs';
  static const String _inspectionRequestsSub = 'inspection_requests';
  static const String _currentDoc = 'current';

  /// Picks a random chef where isOnline == true and not frozen, writes inspection_requests/current,
  /// and returns channel name + chef id so Admin can join Agora immediately.
  Future<InspectionRequestResult?> startRandomInspection() async {
    final adminId = _auth.currentUser?.uid;
    if (adminId == null) return null;

    final onlineSnapshot = await _firestore
        .collection(_chefsCollection)
        .where('isOnline', isEqualTo: true)
        .get();

    final now = DateTime.now();
    final eligible = onlineSnapshot.docs.where((doc) {
      final data = doc.data();
      final frozenUntil = data['frozenUntil'];
      if (frozenUntil == null) return true;
      DateTime? until;
      if (frozenUntil is DateTime) until = frozenUntil;
      if (frozenUntil is Timestamp) until = frozenUntil.toDate();
      return until == null || now.isAfter(until);
    }).toList();

    if (eligible.isEmpty) return null;

    final random = Random();
    final doc = eligible[random.nextInt(eligible.length)];
    final chefId = doc.id;
    final chefName = doc.data()['name'] as String?;

    final channelName = 'inspection_${chefId}_${DateTime.now().millisecondsSinceEpoch}';

    await _firestore
        .collection(_chefsCollection)
        .doc(chefId)
        .collection(_inspectionRequestsSub)
        .doc(_currentDoc)
        .set({
      'channelName': channelName,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'adminId': adminId,
    });

    return InspectionRequestResult(
      channelName: channelName,
      chefId: chefId,
      chefName: chefName,
    );
  }

  /// Called when Admin ends the call (e.g. hang up). Clears current request so Chef UI resets.
  Future<void> clearInspectionRequest(String chefId) async {
    await _firestore
        .collection(_chefsCollection)
        .doc(chefId)
        .collection(_inspectionRequestsSub)
        .doc(_currentDoc)
        .delete();
  }
}
