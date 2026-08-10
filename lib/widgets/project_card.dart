import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_utils.dart';
import '../models/project_model.dart';
import '../screens/project_details_screen.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final bool large;

  const ProjectCard({super.key, required this.project, this.large = false});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppTheme.mediumDuration,
        curve: AppTheme.defaultCurve,
        transform: Matrix4.translationValues(0, _hovered ? -8 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 36,
                    offset: const Offset(0, 14),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.border.withValues(alpha: 0.6),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProjectVisual(project: widget.project, hovered: _hovered),
            Padding(
              padding: EdgeInsets.all(isMobile ? 22 : 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.25),
                      ),
                    ),
                     child: Text(
                      widget.project.category,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.project.name,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 24 : 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.project.shortDescription,
                    style: GoogleFonts.inter(
                      fontSize: 14.5,
                      height: 1.65,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tech in widget.project.technologies.take(5))
                        _TechChip(label: tech),
                      if (widget.project.technologies.length > 5)
                        _TechChip(
                          label: '+${widget.project.technologies.length - 5}',
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _ViewDetailsButton(
                          onTap: () {
                            Navigator.of(
                              context,
                            ).push(ProjectDetailsScreen.page(widget.project));
                          },
                        ),
                      ),
                      if (widget.project.githubUrl != null) ...[
                        const SizedBox(width: 10),
                        _GitHubButton(url: widget.project.githubUrl!),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectVisual extends StatelessWidget {
  final Project project;
  final bool hovered;

  const _ProjectVisual({required this.project, required this.hovered});

  @override
  Widget build(BuildContext context) {
    final primaryColor = project.screenshotColors.first;
    final hasLogo = project.logoAsset != null;
    final hasScreenshot = project.screenshotAssets.isNotEmpty;

    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            project.screenshotColors[0].withValues(alpha: 0.7),
            project.screenshotColors[1].withValues(alpha: 0.35),
            AppColors.background,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 12,
            bottom: -10,
            child: Transform.rotate(
              angle: 0.08,
              child: Container(
                width: 76,
                height: 130,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.card.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.borderHover.withValues(alpha: 0.7),
                  ),
                ),
                child: hasScreenshot
                    ? Image.asset(
                        project.screenshotAssets.last,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        project.screenshotIcons.first,
                        size: 34,
                        color: primaryColor.withValues(alpha: 0.7),
                      ),
              ),
            ),
          ),
          Positioned(
            left: 8,
            top: 14,
            child: Container(
              width: 52,
              height: 52,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.borderHover),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: hasLogo
                  ? Image.asset(project.logoAsset!, fit: BoxFit.contain)
                  : Icon(
                      project.screenshotIcons[1],
                      color: AppColors.primary,
                      size: 25,
                    ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 16,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _VisualChip(
                  label: project.technologies[0],
                  color: primaryColor,
                ),
                if (project.technologies.length > 1)
                  _VisualChip(
                    label: project.technologies[1],
                    color: project.screenshotColors[2],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VisualChip extends StatelessWidget {
  final String label;
  final Color color;

  const _VisualChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(fontSize: 10, color: color),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _ViewDetailsButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ViewDetailsButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        height: 42,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_forward_rounded,
              size: 16,
              color: AppColors.textOnPrimary,
            ),
            const SizedBox(width: 7),
            Text(
              'View Details',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textOnPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GitHubButton extends StatelessWidget {
  final String url;

  const _GitHubButton({required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => UrlUtils.open(url),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderHover),
        ),
        child: Icon(Icons.code_rounded, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}
