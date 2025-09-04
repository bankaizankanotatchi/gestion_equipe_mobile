// lib/presentation/screens/messages/components/message_search_delegate.dart
import 'package:flutter/material.dart';

class MessageSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implémentation de la recherche
    return const Center(child: Text('Fonctionnalité de recherche'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions de recherche
    return const Center(child: Text('Suggestions de recherche'));
  }
}