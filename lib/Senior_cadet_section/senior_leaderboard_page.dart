import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_explorer/services/leaderboard_service.dart';

class SeniorLeaderboardPage extends StatelessWidget {
  const SeniorLeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 252),
      appBar: AppBar(
        title: const Text(
          'Senior Leaderboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: LeaderboardService.instance.seniorLeaderboardStream(),
        builder:
            (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return _LeaderboardErrorView(error: snapshot.error!);
              }

              final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                  snapshot.data?.docs ??
                  <QueryDocumentSnapshot<Map<String, dynamic>>>[];

              if (docs.isEmpty) {
                return const Center(
                  child: Text(
                    'No scores yet. Complete a quiz to join the leaderboard.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: docs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (BuildContext context, int index) {
                  final Map<String, dynamic> data = docs[index].data();
                  final String email = (data['email'] as String?) ?? 'Unknown';
                  final int overallScore =
                      (data['overallScore'] as num?)?.toInt() ?? 0;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: _rankBadge(index),
                      title: Text(
                        email,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text('Class 6-10'),
                      trailing: Text(
                        '$overallScore pts',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
      ),
    );
  }
}

Widget _rankBadge(int index) {
  final int rank = index + 1;

  if (rank <= 3) {
    final Color crownColor = switch (rank) {
      1 => const Color(0xFFFFD700),
      2 => const Color(0xFFC0C0C0),
      _ => const Color(0xFFCD7F32),
    };

    return SizedBox(
      width: 50,
      height: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.workspace_premium, color: crownColor, size: 18),
          const SizedBox(height: 2),
          CircleAvatar(
            radius: 17,
            backgroundColor: crownColor.withOpacity(0.18),
            child: Text(
              '$rank',
              style: TextStyle(color: crownColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  return CircleAvatar(
    backgroundColor: Colors.deepPurple,
    child: Text(
      '$rank',
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

class _LeaderboardErrorView extends StatelessWidget {
  final Object error;

  const _LeaderboardErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    final (_title, _hint, _details) = _mapError(error);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 54, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              _title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _hint,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              _details,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  (String, String, String) _mapError(Object err) {
    if (err is FirebaseException) {
      if (err.code == 'permission-denied') {
        return (
          'Permission Denied',
          'Deploy Firestore rules and allow authenticated read on senior_leaderboard.',
          'Code: ${err.code}',
        );
      }
      if (err.code == 'failed-precondition') {
        return (
          'Firestore Index Missing',
          'Create the required Firestore index from Firebase console error link.',
          'Code: ${err.code}',
        );
      }
      return (
        'Leaderboard Load Failed',
        'Please verify Firestore is enabled and app is connected to the correct Firebase project.',
        'Code: ${err.code} | ${err.message ?? 'No message'}',
      );
    }

    if (err is PlatformException && err.code == 'channel-error') {
      return (
        'Native Channel Not Ready',
        'Stop app, uninstall from device, then run again. Hot reload is not enough after adding Firebase plugins.',
        'Code: ${err.code}',
      );
    }

    return (
      'Leaderboard Load Failed',
      'Unexpected error while reading leaderboard data.',
      err.toString(),
    );
  }
}
