// lib/presentation/screens/messages/new_chat/widgets/search_bar.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Rechercher un membre...',
          hintStyle: AppTextStyles.body2.copyWith(
            color: Colors.grey.shade500,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: Colors.grey.shade500),
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          )
              : null,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: AppTextStyles.caption.fontSize! / 2,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}