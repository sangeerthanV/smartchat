import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Save message to Firestore under current user's collection
  Future<void> saveMessage(String text, bool isUser) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection('users').doc(uid).collection('messages').add({
      'text': text,
      'isUser': isUser,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// Get all messages from Firestore (ordered by timestamp)
  Stream<List<Map<String, dynamic>>> getMessages() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Clear all chat messages for current user (optional feature)
  Future<void> clearMessages() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final messages = await _firestore
        .collection('users')
        .doc(uid)
        .collection('messages')
        .get();

    for (var doc in messages.docs) {
      await doc.reference.delete();
    }
  }
}
