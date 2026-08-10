import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_utils.dart';
import '../models/project_model.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Project project;

  const ProjectDetailsScreen({super.key, required this.project});

  static Route<void> page(Project project) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ProjectDetailsScreen(project: project),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 450),
      reverseTransitionDuration: const Duration(milliseconds: 350),
    );
  }

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  int _currentScreenshot = 0;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final isMobile = ResponsiveUtils.isMobile(context);
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
              color: AppColors.textPrimary,
              tooltip: 'Back',
            ),
            title: Text(
              project.name,
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            actions: [
              if (project.githubUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    onPressed: () => UrlUtils.open(project.githubUrl!),
                    icon: const Icon(Icons.code_rounded),
                    color: AppColors.primary,
                    tooltip: 'GitHub',
                  ),
                ),
            ],
          ),

          SliverToBoxAdapter(child: _HeroBanner(project: project)),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 40,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  project.name,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 32 : 42,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Text(
                    project.category,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                _SectionBlock(
                  icon: Icons.description_rounded,
                  title: 'Overview',
                  child: Text(
                    project.overview,
                    style: GoogleFonts.inter(
                      fontSize: 15.5,
                      height: 1.75,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                _SectionBlock(
                  icon: Icons.photo_library_rounded,
                  title: 'Screenshots',
                  child: _ScreenshotCarousel(
                    project: project,
                    currentIndex: _currentScreenshot,
                    onChanged: (index) =>
                        setState(() => _currentScreenshot = index),
                  ),
                ),
                const SizedBox(height: 32),

                _SectionBlock(
                  icon: Icons.checklist_rounded,
                  title: 'Key Features',
                  child: _FeatureList(features: project.features),
                ),
                const SizedBox(height: 32),

                _SectionBlock(
                  icon: Icons.bolt_rounded,
                  title: 'Technologies',
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final tech in project.technologies)
                        _TechPill(label: tech),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                _SectionBlock(
                  icon: Icons.account_tree_rounded,
                  title: 'Architecture',
                  child: _BulletList(items: project.architecture),
                ),
                const SizedBox(height: 32),

                _SectionBlock(
                  icon: Icons.extension_rounded,
                  title: 'Challenges & Solutions',
                  child: _BulletList(items: project.challenges),
                ),
                const SizedBox(height: 40),

                _LinksRow(project: project),
                const SizedBox(height: 60),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final Project project;

  const _HeroBanner({required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final hasLogo = project.logoAsset != null;
    final hasScreenshot = project.screenshotAssets.isNotEmpty;

    return Container(
      height: isMobile ? 220 : 320,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            project.screenshotColors[0].withValues(alpha: 0.55),
            project.screenshotColors[1].withValues(alpha: 0.3),
            AppColors.background,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: isMobile ? -20 : 40,
            top: isMobile ? 10 : 20,
            child: Opacity(
              opacity: 0.25,
              child: hasLogo
                  ? Image.asset(
                      project.logoAsset!,
                      width: isMobile ? 120 : 200,
                      fit: BoxFit.contain,
                    )
                  : Icon(
                      project.screenshotIcons[1],
                      size: isMobile ? 120 : 200,
                      color: project.screenshotColors[0],
                    ),
            ),
          ),
          Center(
            child: Container(
              width: isMobile ? 120 : 160,
              height: isMobile ? 170 : 230,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.card.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(isMobile ? 20 : 26),
                border: Border.all(
                  color: AppColors.borderHover.withValues(alpha: 0.8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: hasScreenshot
                  ? Image.asset(
                      project.screenshotAssets.last,
                      fit: BoxFit.cover,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          project.screenshotIcons.first,
                          size: isMobile ? 40 : 54,
                          color: project.screenshotColors[0],
                        ),
                        SizedBox(height: isMobile ? 10 : 14),
                        Text(
                          project.name,
                          style: GoogleFonts.inter(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScreenshotCarousel extends StatelessWidget {
  final Project project;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const _ScreenshotCarousel({
    required this.project,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Column(
      children: [
        AnimatedSwitcher(
          duration: AppTheme.mediumDuration,
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.96, end: 1).animate(animation),
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey(currentIndex),
            height: isMobile ? 520 : 600,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderHover),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (project.screenshotAssets.isNotEmpty)
                  Image.asset(
                    project.screenshotAssets[currentIndex],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.secondaryBackground,
                      child: Center(
                        child: Icon(
                          project.screenshotIcons[currentIndex],
                          size: isMobile ? 56 : 72,
                          color: project.screenshotColors[currentIndex],
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          project.screenshotColors[currentIndex].withValues(
                            alpha: 0.5,
                          ),
                          project
                              .screenshotColors[(currentIndex + 1) %
                                  project.screenshotColors.length]
                              .withValues(alpha: 0.25),
                          AppColors.card,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        project.screenshotIcons[currentIndex],
                        size: isMobile ? 56 : 72,
                        color: project.screenshotColors[currentIndex],
                      ),
                    ),
                  ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.background.withValues(alpha: 0.85),
                          AppColors.background.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          project.screenshotIcons[currentIndex],
                          size: 16,
                          color: project.screenshotColors[currentIndex],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            project.screenshotLabels[currentIndex],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Text(
                          '${currentIndex + 1} / ${project.screenshotLabels.length}',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: project.screenshotLabels.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final selected = index == currentIndex;
              return InkWell(
                onTap: () => onChanged(index),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: AppTheme.fastDuration,
                  width: 56,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.borderHover,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: project.screenshotAssets.isNotEmpty
                      ? Image.asset(
                          project.screenshotAssets[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            project.screenshotIcons[index],
                            size: 22,
                            color: selected
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                        )
                      : Icon(
                          project.screenshotIcons[index],
                          size: 22,
                          color: selected
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _SectionBlock({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        child,
      ],
    );
  }
}

class _FeatureList extends StatelessWidget {
  final List<String> features;

  const _FeatureList({required this.features});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final feature in features)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_rounded, size: 15, color: AppColors.success),
                const SizedBox(width: 7),
                Text(
                  feature,
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _TechPill extends StatelessWidget {
  final String label;

  const _TechPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12.5,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;

  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 7),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  items[i],
                  style: GoogleFonts.inter(
                    fontSize: 14.5,
                    height: 1.65,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          if (i != items.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _LinksRow extends StatelessWidget {
  final Project project;

  const _LinksRow({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Links',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              if (project.githubUrl != null)
                _LinkButton(
                  icon: Icons.code_rounded,
                  label: 'GitHub Repository',
                  url: project.githubUrl!,
                ),
              _LinkButton(
                icon: Icons.mail_rounded,
                label: 'Contact Me',
                url: 'mailto:${AppConstants.email}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _LinkButton({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: () => UrlUtils.open(widget.url),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: AppTheme.fastDuration,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            gradient: _hovered ? AppColors.primaryGradient : null,
            color: _hovered ? null : AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.borderHover,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 17,
                color: _hovered
                    ? AppColors.textOnPrimary
                    : AppColors.primary,
              ),
              const SizedBox(width: 9),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _hovered
                      ? AppColors.textOnPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
