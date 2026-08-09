import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/theme/app_theme.dart';
import '../data/projects_data.dart';
import 'common/section_header.dart';

/// Skills section with modern category cards and hover effects.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
            eyebrow: 'Skills',
            title: 'My technical toolkit',
            subtitle:
                'Technologies and tools I use to build modern applications '
                'from the ground up.',
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = ResponsiveUtils.gridColumns(context, max: 4);
              final width = constraints.maxWidth - (columns - 1) * 16;
              final cardWidth = width / columns;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (final category in SkillsData.categories)
                    SizedBox(
                      width: cardWidth,
                      child: _SkillCategoryCard(
                        title: category.title,
                        items: category.items,
                      ),
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

class _SkillCategoryCard extends StatefulWidget {
  final String title;
  final List<({String name, IconData icon})> items;

  const _SkillCategoryCard({required this.title, required this.items});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
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
        padding: const EdgeInsets.all(24),
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
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _categoryIcon(widget.title),
                    size: 19,
                    color: AppColors.textOnPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Divider(color: AppColors.border),
            const SizedBox(height: 12),
            for (final item in widget.items) ...[
              _SkillRow(name: item.name, icon: item.icon),
              if (item != widget.items.last) const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  IconData _categoryIcon(String title) {
    switch (title) {
      case 'Frontend':
        return Icons.dashboard_rounded;
      case 'State Management':
        return Icons.account_tree_rounded;
      case 'Backend & Database':
        return Icons.storage_rounded;
      default:
        return Icons.handyman_rounded;
    }
  }
}

class _SkillRow extends StatelessWidget {
  final String name;
  final IconData icon;

  const _SkillRow({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 15, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
