// lib/presentation/screens/messages/new_chat/widgets/filter_chips.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/app_constants.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';
import 'package:team_manager_app/data/models/user.dart';

class FilterChips extends StatelessWidget {
  final UserType selectedFilter;
  final ValueChanged<UserType> onFilterChanged;

  const FilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  String _getUserTypeLabel(UserType type) {
    switch (type) {
      case UserType.coach:
        return 'Entraîneurs';
      case UserType.player:
        return 'Joueurs';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      color: Colors.grey.shade50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              'Filtrer: ',
              style: AppTextStyles.caption.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            ...UserType.values.map((type) {
              final isSelected = selectedFilter == type;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(
                    _getUserTypeLabel(type),
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected ? Colors.white : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) => onFilterChanged(selected ? type : UserType.player),
                  backgroundColor: Colors.white,
                  selectedColor: AppColors.primary,
                  side: BorderSide(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  checkmarkColor: Colors.white,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}