import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import 'common/scroll_reveal.dart';
import 'common/section_header.dart';
import 'interactive_background.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return InteractiveBackground(
      particleCount: 30,
      glowIntensity: 0.4,
      animationSpeed: 0.8,
      interactionRadius: 160,
      opacity: 0.4,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: ResponsiveUtils.sectionVerticalPadding(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'About Me',
              title: 'A quick look at who I am',
            ),
            const SizedBox(height: 48),
            LayoutBuilder(
              builder: (context, constraints) {
                final showSideBySide = constraints.maxWidth >= 900;

                if (showSideBySide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _AboutText()),
                      const SizedBox(width: 48),
                      Expanded(flex: 2, child: _ProfileCard()),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AboutText(),
                    const SizedBox(height: 40),
                    _ProfileCard(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          child: Text(
            'I am a Computer Science graduate and Flutter Developer interested '
            'in building modern mobile applications with clean architecture, '
            'scalable code, and intuitive user experiences.',
            style: GoogleFonts.inter(
              fontSize: 18,
              height: 1.75,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 32),
        ScrollReveal(
          delay: const Duration(milliseconds: 100),
          child: Text(
            'Main Areas',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final area in _areas)
              ScrollReveal(
                delay: const Duration(milliseconds: 50),
                offset: 16,
                child: _AreaChip(label: area),
              ),
          ],
        ),
      ],
    );
  }
}

const List<String> _areas = [
  'Flutter & Dart',
  'State Management',
  'REST APIs',
  'Backend Integration',
  'Firebase',
  'Supabase',
  'Clean Architecture',
  'Git & GitHub',
];

class _AreaChip extends StatelessWidget {
  final String label;

  const _AreaChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, size: 14, color: AppColors.primary),
          const SizedBox(width: 7),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppConstants.profilePhotoAsset,
                      width: 74,
                      height: 74,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.card, width: 2.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              AppConstants.fullName,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppConstants.role,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.primarySoft,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Divider(color: AppColors.border),
            const SizedBox(height: 8),
            for (final item in const [
              (icon: Icons.school_rounded, label: 'Computer Science Graduate'),
              (
                icon: Icons.phone_android_rounded,
                label: 'Mobile App Development',
              ),
            ]) ...[
              _ProfileRow(icon: item.icon, label: item.label),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, size: 17, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
