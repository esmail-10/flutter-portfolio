import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_utils.dart';
import 'common/scroll_reveal.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return Container(
      width: double.infinity,
      color: AppColors.secondaryBackground,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: ResponsiveUtils.sectionVerticalPadding(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ScrollReveal(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 32 : 56),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.borderHover),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    blurRadius: 60,
                    offset: const Offset(0, 30),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.rocket_launch_rounded,
                      size: 34,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Let\'s Build Something Great Together',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 26 : 36,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Have a project idea or looking for a Flutter Developer? '
                    'Feel free to get in touch.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15.5,
                      height: 1.7,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _ContactPrimaryButton(
                        label: 'Contact Me',
                        icon: Icons.mail_rounded,
                        url: 'mailto:${AppConstants.email}',
                      ),
                      _ContactGhostButton(
                        label: 'GitHub',
                        icon: Icons.code_rounded,
                        url: AppConstants.githubUrl,
                      ),
                      _ContactGhostButton(
                        label: 'LinkedIn',
                        icon: Icons.work_rounded,
                        url: AppConstants.linkedinUrl,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactPrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;

  const _ContactPrimaryButton({
    required this.label,
    required this.icon,
    required this.url,
  });

  @override
  State<_ContactPrimaryButton> createState() => _ContactPrimaryButtonState();
}

class _ContactPrimaryButtonState extends State<_ContactPrimaryButton> {
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
          curve: AppTheme.defaultCurve,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
          decoration: BoxDecoration(
            gradient: _hovered
                ? const LinearGradient(
                    colors: [AppColors.primarySoft, AppColors.primary],
                  )
                : AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 17, color: AppColors.textOnPrimary),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactGhostButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;

  const _ContactGhostButton({
    required this.label,
    required this.icon,
    required this.url,
  });

  @override
  State<_ContactGhostButton> createState() => _ContactGhostButtonState();
}

class _ContactGhostButtonState extends State<_ContactGhostButton> {
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
          curve: AppTheme.defaultCurve,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.08)
                : Colors.transparent,
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
                color: _hovered ? AppColors.primarySoft : AppColors.textPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: _hovered
                      ? AppColors.primarySoft
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
