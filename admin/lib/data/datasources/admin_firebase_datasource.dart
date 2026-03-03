import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

/// Firestore paths match TC app: users, chefs, orders. Reject writes to both users and chefs.
class AdminFirebaseDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _users = 'users';
  static const String _chefs = 'chefs';
  static const String _adminNotifications = 'admin_notifications';
  static const String _conversations = 'conversations';

  Stream<List<UserModel>> watchPendingChefs() {
    return _firestore
        .collection(_users)
        .where('role', isEqualTo: 'chef')
        .where('chefApprovalStatus', isEqualTo: 'pending')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => UserModel.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Stream<int> watchPendingChefsCount() {
    return watchPendingChefs().map((list) => list.length);
  }

  Future<List<UserModel>> getAllChefs() async {
    final snap = await _firestore.collection(_users).where('role', isEqualTo: 'chef').get();
    return snap.docs.map((doc) => UserModel.fromJson({...doc.data(), 'id': doc.id})).toList();
  }

  Future<UserModel?> getChefById(String chefId) async {
    final doc = await _firestore.collection(_users).doc(chefId).get();
    if (!doc.exists) return null;
    return UserModel.fromJson({...doc.data()!, 'id': doc.id});
  }

  Future<void> approveChef(String chefId) {
    return _firestore.collection(_users).doc(chefId).update({'chefApprovalStatus': 'approved'});
  }

  /// Reject: update users + chefs/{chefId}.rejectionReason (for TC ChefRejectionScreen). Cloud Function can send email.
  Future<void> rejectChef(String chefId, {required String reason}) async {
    await _firestore.collection(_users).doc(chefId).update({
      'chefApprovalStatus': 'rejected',
      'rejectionReason': reason,
    });
    await _firestore.collection(_chefs).doc(chefId).set(
      {'rejectionReason': reason},
      SetOptions(merge: true),
    );
  }

  Future<List<UserModel>> getAllCustomers() async {
    final snap = await _firestore.collection(_users).where('role', isEqualTo: 'customer').get();
    return snap.docs.map((doc) => UserModel.fromJson({...doc.data(), 'id': doc.id})).toList();
  }

  /// Chef profile from chefs/{chefId}: documents (nationalId, healthCert), strikeCount, frozenUntil, chefStatus, violationHistory.
  Future<Map<String, dynamic>?> getChefDoc(String chefId) async {
    final doc = await _firestore.collection(_chefs).doc(chefId).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return {'id': doc.id, ...data};
  }

  /// Violation: append to violationHistory, update strikeCount, frozenUntil, chefStatus per punishment.
  Future<void> applyViolation({
    required String chefId,
    required String reason,
    required int newStrikeCount,
    required String punishment,
    DateTime? frozenUntil,
    required String chefStatus,
  }) async {
    final ref = _firestore.collection(_chefs).doc(chefId);
    final doc = await ref.get();
    final data = doc.data() ?? {};
    final history = List<Map<String, dynamic>>.from(data['violationHistory'] as List<dynamic>? ?? []);
    history.add({
      'date': FieldValue.serverTimestamp(),
      'reason': reason,
      'punishment': punishment,
    });
    await ref.set({
      'violationHistory': history,
      'strikeCount': newStrikeCount,
      'frozenUntil': frozenUntil != null ? Timestamp.fromDate(frozenUntil) : null,
      'chefStatus': chefStatus,
    }, SetOptions(merge: true));
  }

  // ─── Admin notifications (admin_notifications collection) ─────────────
  Stream<List<Map<String, dynamic>>> watchAdminNotifications() {
    return _firestore
        .collection(_adminNotifications)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final data = d.data();
              return {
                'id': d.id,
                'title': data['title'] as String? ?? '',
                'body': data['body'] as String? ?? '',
                'createdAt': (data['createdAt'] as Timestamp?)?.toDate().toIso8601String(),
                'read': data['read'] as bool? ?? false,
              };
            }).toList());
  }

  Future<void> markNotificationRead(String id) {
    return _firestore.collection(_adminNotifications).doc(id).update({'read': true});
  }

  Future<void> markAllNotificationsRead() async {
    final snap = await _firestore.collection(_adminNotifications).where('read', isEqualTo: false).get();
    for (final doc in snap.docs) {
      await doc.reference.update({'read': true});
    }
  }

  // ─── Support conversations (type customer-support or chef-support) ─────
  Stream<List<Map<String, dynamic>>> watchSupportConversations() {
    return _firestore
        .collection(_conversations)
        .where('type', whereIn: ['customer-support', 'chef-support'])
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final data = d.data();
              return {
                'id': d.id,
                'type': data['type'] as String?,
                'participantName': data['participantName'] as String? ?? '—',
                'lastMessage': data['lastMessage'] as String? ?? '',
                'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate().toIso8601String(),
                'unreadCount': data['adminUnreadCount'] as int? ?? 0,
              };
            }).toList());
  }

  Stream<int> watchSupportUnreadCount() {
    return watchSupportConversations().map((list) => list.fold<int>(0, (s, c) => s + ((c['unreadCount'] as int?) ?? 0)));
  }

  Stream<List<Map<String, dynamic>>> watchConversationMessages(String conversationId) {
    return _firestore
        .collection(_conversations)
        .doc(conversationId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final data = d.data();
              return {
                'id': d.id,
                'text': data['text'] as String? ?? '',
                'senderId': data['senderId'] as String?,
                'isAdmin': data['isAdmin'] as bool? ?? false,
                'createdAt': (data['createdAt'] as Timestamp?)?.toDate().toIso8601String(),
              };
            }).toList());
  }

  Future<void> sendSupportMessage(String conversationId, String text) async {
    final adminId = FirebaseAuth.instance.currentUser?.uid ?? 'admin';
    await _firestore
        .collection(_conversations)
        .doc(conversationId)
        .collection('messages')
        .add({
      'text': text,
      'senderId': adminId,
      'isAdmin': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _firestore.collection(_conversations).doc(conversationId).update({
      'lastMessage': text,
      'updatedAt': FieldValue.serverTimestamp(),
      'adminUnreadCount': 0,
    });
  }
}
