import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_utils.dart';
import 'common/brand_icons.dart';
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
          constraints: const BoxConstraints(maxWidth: 820),
          child: ScrollReveal(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 24 : 48),
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
                  const _ProfileAvatarHeader(),

                  const SizedBox(height: 24),

                  Text(
                    'Let\'s Build Something Great Together',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 24 : 34,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Have a project idea or looking for a Flutter Developer? '
                    'Feel free to get in touch.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      height: 1.65,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 36),

                  const _ContactInfoGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatarHeader extends StatelessWidget {
  const _ProfileAvatarHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              AppConstants.profilePhotoAsset,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: Tooltip(
            message: 'Available for opportunities',
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.card, width: 3.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.success.withValues(alpha: 0.5),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactInfoGrid extends StatelessWidget {
  const _ContactInfoGrid();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    final items = [
      _ContactItemData(
        title: 'Location',
        value: AppConstants.location,
        leading: Icon(
          Icons.location_on_rounded,
          size: 18,
          color: AppColors.primary,
        ),
        url: null,
      ),
      _ContactItemData(
        title: 'Phone / WhatsApp',
        value: AppConstants.displayPhone,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.phone_rounded, size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            WhatsAppBrandIcon(size: 16, color: AppColors.primarySoft),
          ],
        ),
        url: UrlUtils.whatsappUrl(AppConstants.whatsappNumber),
      ),
      _ContactItemData(
        title: 'Email',
        value: AppConstants.email,
        leading: Icon(Icons.mail_rounded, size: 18, color: AppColors.primary),
        url: 'mailto:${AppConstants.email}',
      ),
      _ContactItemData(
        title: 'GitHub',
        value: AppConstants.githubDisplay,
        leading: GitHubBrandIcon(size: 18, color: AppColors.primary),
        url: AppConstants.githubUrl,
      ),
      _ContactItemData(
        title: 'Facebook',
        value: AppConstants.facebookDisplay,
        leading: FacebookBrandIcon(size: 18, color: AppColors.primary),
        url: AppConstants.facebookUrl,
      ),
      _ContactItemData(
        title: 'LinkedIn',
        value: AppConstants.linkedinDisplay,
        leading: LinkedInBrandIcon(size: 18, color: AppColors.primary),
        url: AppConstants.linkedinUrl,
      ),
    ];

    if (isMobile) {
      return Column(
        children: [
          for (final item in items) ...[
            _ContactInfoTile(data: item),
            const SizedBox(height: 12),
          ],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final halfWidth = (constraints.maxWidth - 16) / 2;
        return Wrap(
          spacing: 16,
          runSpacing: 14,
          children: [
            for (final item in items)
              SizedBox(
                width: halfWidth,
                child: _ContactInfoTile(data: item),
              ),
          ],
        );
      },
    );
  }
}

class _ContactItemData {
  final String title;
  final String value;
  final Widget leading;
  final String? url;

  const _ContactItemData({
    required this.title,
    required this.value,
    required this.leading,
    this.url,
  });
}

class _ContactInfoTile extends StatefulWidget {
  final _ContactItemData data;

  const _ContactInfoTile({required this.data});

  @override
  State<_ContactInfoTile> createState() => _ContactInfoTileState();
}

class _ContactInfoTileState extends State<_ContactInfoTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isClickable = widget.data.url != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: isClickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: isClickable ? () => UrlUtils.open(widget.data.url!) : null,
        child: AnimatedContainer(
          duration: AppTheme.fastDuration,
          curve: AppTheme.defaultCurve,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.cardHover
                : AppColors.card.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.6)
                  : AppColors.border,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              AnimatedScale(
                scale: _hovered ? 1.08 : 1.0,
                duration: AppTheme.fastDuration,
                curve: AppTheme.defaultCurve,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: _hovered
                        ? AppColors.primary.withValues(alpha: 0.18)
                        : AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _hovered
                          ? AppColors.primary.withValues(alpha: 0.3)
                          : Colors.transparent,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: widget.data.leading,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.data.title,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.data.value,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _hovered && isClickable
                            ? AppColors.primarySoft
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isClickable) ...[
                const SizedBox(width: 6),
                AnimatedOpacity(
                  duration: AppTheme.fastDuration,
                  opacity: _hovered ? 1.0 : 0.4,
                  child: Icon(
                    Icons.arrow_outward_rounded,
                    size: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
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
                ? LinearGradient(
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
