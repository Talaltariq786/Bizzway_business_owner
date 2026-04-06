import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'auth_wave_clipper.dart';

/// Gradient header with wave — shared by [AuthHeaderSection] and role login screens.
class AuthBrandedHeader extends StatelessWidget {
  const AuthBrandedHeader({
    super.key,
    required this.topPadding,
    required this.headline,
    required this.tagline,
    this.bottomPadding = 36,
  });

  final double topPadding;
  final String headline;
  final String tagline;

  /// Extra space at bottom (e.g. 52 when a floating tab bar overlaps).
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const AuthHeaderWaveClipper(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: topPadding + 24,
          left: 28,
          right: 28,
          bottom: bottomPadding,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gradientPrimary[0],
              Color.lerp(
                AppColors.gradientPrimary[1],
                const Color(0xFF5B3FA8),
                0.25,
              )!,
              AppColors.gradientPrimary[1],
            ],
            stops: const [0.0, 0.45, 1.0],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.45),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.store_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              headline,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tagline,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 13.5,
                height: 1.4,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: 44,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.15),
                    Colors.white.withValues(alpha: 0.55),
                    Colors.white.withValues(alpha: 0.15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
