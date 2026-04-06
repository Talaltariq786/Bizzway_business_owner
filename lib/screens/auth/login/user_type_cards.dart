import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class UserTypeToggleCard extends StatelessWidget {
  const UserTypeToggleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.expandInParent = true,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  /// When false (e.g. horizontal scroll row), card uses intrinsic width.
  final bool expandInParent;

  @override
  Widget build(BuildContext context) {
    final card = SizedBox(
      height: 102,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: AppColors.gradientPrimary,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isSelected ? null : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.28),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 9.5,
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.88)
                      : AppColors.textSecondary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (expandInParent) {
      return Expanded(child: card);
    }
    return SizedBox(width: 118, child: card);
  }
}
