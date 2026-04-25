import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LeaderboardService {
  LeaderboardService._();

  static final LeaderboardService instance = LeaderboardService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _usersCollection = 'users';
  static const String _attemptsCollection = 'senior_attempts';
  static const String _leaderboardCollection = 'senior_leaderboard';
  static const String _classGroupSenior = 'senior';

  Future<bool> markUserAsSenior() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }

    try {
      await _firestore.collection(_usersCollection).doc(user.uid).set({
        'uid': user.uid,
        'email': user.email ?? 'Unknown',
        'classGroup': _classGroupSenior,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return true;
    } on FirebaseException catch (e) {
      debugPrint('markUserAsSenior failed: ${e.code} ${e.message}');
      return false;
    } catch (e) {
      debugPrint('markUserAsSenior failed: $e');
      return false;
    }
  }

  Future<bool> saveSeniorQuizAttempt({
    required String moduleId,
    required int score,
    required int total,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }

    try {
      final DocumentReference<Map<String, dynamic>> userDoc = _firestore
          .collection(_usersCollection)
          .doc(user.uid);

      await userDoc.set({
        'uid': user.uid,
        'email': user.email ?? 'Unknown',
        'classGroup': _classGroupSenior,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await userDoc.collection(_attemptsCollection).add({
        'moduleId': moduleId,
        'score': score,
        'total': total,
        'attemptedAt': FieldValue.serverTimestamp(),
      });

      final QuerySnapshot<Map<String, dynamic>> attemptsSnapshot = await userDoc
          .collection(_attemptsCollection)
          .get();

      final Map<String, int> maxScoresByModule = <String, int>{};

      for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
          in attemptsSnapshot.docs) {
        final Map<String, dynamic> data = doc.data();
        final String id = (data['moduleId'] as String?) ?? '';
        if (id.isEmpty) {
          continue;
        }
        final int currentScore = (data['score'] as num?)?.toInt() ?? 0;
        final int existingMax = maxScoresByModule[id] ?? 0;
        if (currentScore > existingMax) {
          maxScoresByModule[id] = currentScore;
        }
      }

      final int overallScore = maxScoresByModule.values.fold<int>(
        0,
        (int sum, int item) => sum + item,
      );

      await _firestore.collection(_leaderboardCollection).doc(user.uid).set({
        'uid': user.uid,
        'email': user.email ?? 'Unknown',
        'classGroup': _classGroupSenior,
        'overallScore': overallScore,
        'moduleScores': maxScoresByModule,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return true;
    } on FirebaseException catch (e) {
      debugPrint('saveSeniorQuizAttempt failed: ${e.code} ${e.message}');
      return false;
    } catch (e) {
      debugPrint('saveSeniorQuizAttempt failed: $e');
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> seniorLeaderboardStream() {
    return _firestore
        .collection(_leaderboardCollection)
        .orderBy('overallScore', descending: true)
        .snapshots();
  }
}
