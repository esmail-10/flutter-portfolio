import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/theme/app_theme.dart';
import '../data/projects_data.dart';
import 'common/section_header.dart';

/// Services section — "What I Can Build".
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return Container(
      width: double.infinity,
      color: AppColors.secondaryBackground,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: ResponsiveUtils.sectionVerticalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            eyebrow: 'Services',
            title: 'What I Can Build',
            subtitle:
                'End-to-end mobile and backend-connected products that '
                'feel fast, polished, and reliable.',
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = ResponsiveUtils.gridColumns(context, max: 3);
              final width = constraints.maxWidth - (columns - 1) * 16;
              final cardWidth = width / columns;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (final service in ServicesData.services)
                    SizedBox(
                      width: cardWidth,
                      child: _ServiceCard(service: service),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ({String title, String description, IconData icon}) service;

  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppTheme.mediumDuration,
        curve: AppTheme.defaultCurve,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.cardHover : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                widget.service.icon,
                size: 23,
                color: AppColors.textOnPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.service.title,
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.service.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.65,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
