import 'package:flutter/material.dart';
import '../../services/app_state_provider.dart';
import '../../widgets/dancer_card.dart';
import '../dancers/dancer_profile_screen.dart';

class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    final savedDancers = appState.dancers.where((d) => appState.isDancerSaved(d.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Dancers & Bookmarks')),
      body: savedDancers.isEmpty
          ? const Center(child: Text('No saved dancers yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: savedDancers.length,
              itemBuilder: (context, index) {
                final dancer = savedDancers[index];
                return DancerCard(
                  dancer: dancer,
                  isSaved: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => DancerProfileScreen(dancer: dancer)),
                    );
                  },
                  onSaveTap: () => appState.toggleSaveDancer(dancer.id),
                );
              },
            ),
    );
  }
}
