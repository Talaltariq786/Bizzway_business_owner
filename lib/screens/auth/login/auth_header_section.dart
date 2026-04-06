import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'auth_branded_header.dart';

/// Gradient header, wave clip, and floating Login | Sign Up [TabBar].
class AuthHeaderSection extends StatelessWidget {
  const AuthHeaderSection({
    super.key,
    required this.tabController,
    required this.topPadding,
  });

  final TabController tabController;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        AuthBrandedHeader(
          topPadding: topPadding,
          headline: AppStrings.appName,
          tagline: AppStrings.tagline,
          bottomPadding: 52,
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: -22,
          child: Material(
            color: Colors.white,
            elevation: 12,
            shadowColor: AppColors.primary.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(18),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: TabBar(
                controller: tabController,
                padding: const EdgeInsets.all(5),
                splashBorderRadius: BorderRadius.circular(12),
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.gradientPrimary,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                  letterSpacing: 0.2,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                tabs: const [
                  Tab(text: 'Login'),
                  Tab(text: 'Sign Up'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
