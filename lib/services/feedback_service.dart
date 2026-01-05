import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> submitFeedback({
    required String name,
    required String email,
    required String feedback,
  }) async {
    await _db.collection('feedbacks').add({
      'name': name,
      'email': email,
      'feedback': feedback,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}