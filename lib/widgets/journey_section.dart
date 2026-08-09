import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../data/projects_data.dart';
import 'common/scroll_reveal.dart';
import 'common/section_header.dart';

class JourneySection extends StatelessWidget {
  const JourneySection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: ResponsiveUtils.sectionVerticalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Journey',
            title: 'Learning journey',
            subtitle: 'A timeline of my development path so far.',
          ),
          const SizedBox(height: 48),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                children: [
                  for (var i = 0; i < JourneyData.steps.length; i++) ...[
                    _TimelineItem(
                      step: JourneyData.steps[i],
                      isLast: i == JourneyData.steps.length - 1,
                      delay: Duration(milliseconds: i * 120),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final ({String title, String description, IconData icon}) step;
  final bool isLast;
  final Duration delay;

  const _TimelineItem({
    required this.step,
    required this.isLast,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return ScrollReveal(
      delay: delay,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                children: [
                  Container(
                    width: isMobile ? 44 : 48,
                    height: isMobile ? 44 : 48,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      step.icon,
                      size: 22,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: AppColors.borderHover,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: isLast ? 0 : 40),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: GoogleFonts.inter(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      step.description,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        height: 1.6,
                        color: AppColors.textSecondary,
                      ),
                    ),
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
