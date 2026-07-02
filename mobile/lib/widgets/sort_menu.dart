import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';

class SortMenu extends StatelessWidget {
  const SortMenu({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  static const options = <String, String>{
    'recent': 'Recently added',
    'title': 'Title A–Z',
    'author': 'Author A–Z',
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Sort library',
      initialValue: value,
      onSelected: onChanged,
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.tune_rounded, size: 20),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
      itemBuilder: (context) => options.entries
          .map(
            (entry) => PopupMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  if (entry.key == value)
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.check_rounded, size: 18, color: AppColors.accent),
                    ),
                  Text(entry.value),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
