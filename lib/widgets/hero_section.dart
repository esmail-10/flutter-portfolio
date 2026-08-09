import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widgets/common/brand_icons.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_utils.dart';
import 'common/scroll_reveal.dart';
import 'interactive_background.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return InteractiveBackground(
      particleCount: 45,
      glowIntensity: 0.7,
      animationSpeed: 1.0,
      interactionRadius: 220,
      opacity: 0.7,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        alignment: Alignment.center,
        constraints: const BoxConstraints(maxWidth: 1440),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double contentWidth = constraints.maxWidth;
            final showSideBySide = contentWidth >= 900;

            if (showSideBySide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _HeroCopy(
                      isMobile: false,
                      onViewProjects: () =>
                          SectionController.instance.scrollTo('Projects'),
                    ),
                  ),
                  const SizedBox(width: 56),
                  Expanded(child: _HeroVisual()),
                ],
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroCopy(
                  isMobile: isMobile,
                  onViewProjects: () =>
                      SectionController.instance.scrollTo('Projects'),
                ),
                const SizedBox(height: 56),
                Center(child: _HeroVisual()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onViewProjects;

  const _HeroCopy({required this.isMobile, required this.onViewProjects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ScrollReveal(
          offset: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for opportunities',
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ScrollReveal(
          delay: const Duration(milliseconds: 100),
          offset: 24,
          child: Text(
            'Hi, I\'m ${AppConstants.name}',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 40 : 56,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -1.5,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 6),
        ScrollReveal(
          delay: const Duration(milliseconds: 200),
          offset: 24,
          child: ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.primaryGradient.createShader(bounds),
            child: Text(
              AppConstants.role,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 26 : 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ScrollReveal(
          delay: const Duration(milliseconds: 300),
          offset: 24,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              AppConstants.tagline,
              style: GoogleFonts.inter(
                fontSize: 16.5,
                height: 1.7,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),
        ScrollReveal(
          delay: const Duration(milliseconds: 400),
          offset: 24,
          child: Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              _PrimaryButton(
                label: 'View My Projects',
                icon: Icons.rocket_launch_rounded,
                onTap: onViewProjects,
              ),
              _GhostButton(
                label: 'Download CV',
                icon: Icons.download_rounded,
                onTap: () => UrlUtils.open(AppConstants.cvUrl),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        ScrollReveal(
          delay: const Duration(milliseconds: 500),
          offset: 24,
          child: _SocialRow(),
        ),
      ],
    );
  }
}

class _SocialRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final links = [
      (
        tooltip: 'GitHub',
        url: AppConstants.githubUrl,
        icon: const GitHubBrandIcon(size: 19, color: Colors.white),
      ),
      (
        tooltip: 'LinkedIn',
        url: AppConstants.linkedinUrl,
        icon: const LinkedInBrandIcon(size: 19, color: Colors.white),
      ),
      (
        tooltip: 'Email',
        url: 'mailto:${AppConstants.email}',
        icon: const Icon(Icons.mail_rounded, size: 19, color: Colors.white),
      ),
      (
        tooltip: 'WhatsApp',
        url: UrlUtils.whatsappUrl(AppConstants.whatsappNumber),
        icon: const WhatsAppBrandIcon(size: 19, color: Colors.white),
      ),
    ];

    return Row(
      children: [
        for (var i = 0; i < links.length; i++) ...[
          _SocialIcon(
            tooltip: links[i].tooltip,
            url: links[i].url,
            icon: links[i].icon,
          ),
          if (i != links.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final String tooltip;
  final String url;
  final Widget icon;

  const _SocialIcon({
    required this.tooltip,
    required this.url,
    required this.icon,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _hovered = true);
      },
      onExit: (_) {
        setState(() => _hovered = false);
      },
      child: Tooltip(
        message: widget.tooltip,
        child: InkWell(
          onTap: () => UrlUtils.open(widget.url),
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: AppTheme.fastDuration,
            curve: AppTheme.defaultCurve,
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: _hovered ? AppColors.primaryGradient : null,
              color: _hovered ? null : AppColors.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _hovered ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Center(
              child: _hovered
                  ? widget.icon
                  : _changeIconColor(widget.icon, AppColors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _changeIconColor(Widget icon, Color color) {
    if (icon is Icon) {
      return Icon(
        icon.icon,
        size: icon.size,
        color: color,
        semanticLabel: icon.semanticLabel,
      );
    }

    if (icon is GitHubBrandIcon) {
      return GitHubBrandIcon(
        size: icon.size,
        color: color,
        url: icon.url,
        tooltip: icon.tooltip,
      );
    }

    if (icon is LinkedInBrandIcon) {
      return LinkedInBrandIcon(size: icon.size, color: color);
    }

    if (icon is WhatsAppBrandIcon) {
      return WhatsAppBrandIcon(size: icon.size, color: color);
    }

    return icon;
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: AppTheme.fastDuration,
          curve: AppTheme.defaultCurve,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
                      color: AppColors.primary.withValues(alpha: 0.28),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: AppColors.textOnPrimary),
              const SizedBox(width: 9),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 15,
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

class _GhostButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _GhostButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: AppTheme.fastDuration,
          curve: AppTheme.defaultCurve,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
                size: 18,
                color: _hovered ? AppColors.primarySoft : AppColors.textPrimary,
              ),
              const SizedBox(width: 9),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 15,
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

/// Animated Flutter-themed abstract developer visual.
class _HeroVisual extends StatefulWidget {
  @override
  State<_HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<_HeroVisual>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveUtils.isMobile(context)
        ? 300.0
        : MediaQuery.sizeOf(context).width >= 1200
        ? 420.0
        : 360.0;

    return SizedBox(
      width: size,
      height: size * 0.9,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              final t = Curves.easeInOut.transform(_glowController.value);
              return Container(
                width: size * (0.92 + t * 0.1),
                height: size * (0.92 + t * 0.1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.16 - t * 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
          CustomPaint(
            size: Size(size, size),
            painter: _OrbitRingPainter(
              AppColors.primary.withValues(alpha: 0.14),
            ),
          ),
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              final dy =
                  Curves.easeInOut.transform(_floatController.value) * 16;
              return Transform.translate(
                offset: Offset(0, -4 + dy),
                child: child,
              );
            },
            child: _ProfileHeroVisual(size: size),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeroVisual extends StatefulWidget {
  final double size;

  const _ProfileHeroVisual({required this.size});

  @override
  State<_ProfileHeroVisual> createState() => _ProfileHeroVisualState();
}

class _ProfileHeroVisualState extends State<_ProfileHeroVisual> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final avatarSize = widget.size * 0.62;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Ambient Glow backdrop behind profile
          AnimatedContainer(
            duration: AppTheme.fastDuration,
            width: avatarSize * 1.15,
            height: avatarSize * 1.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(
                    alpha: _hovered ? 0.45 : 0.28,
                  ),
                  blurRadius: _hovered ? 50 : 35,
                  spreadRadius: _hovered ? 8 : 4,
                ),
              ],
            ),
          ),

          // Main Profile Avatar Container with double gradient border
          AnimatedScale(
            scale: _hovered ? 1.04 : 1.0,
            duration: AppTheme.fastDuration,
            curve: AppTheme.defaultCurve,
            child: Container(
              width: avatarSize,
              height: avatarSize,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.card,
                ),
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: Image.asset(
                    AppConstants.profilePhotoAsset,
                    width: avatarSize,
                    height: avatarSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Floating Chip Top-Left
          Positioned(
            left: -widget.size * 0.04,
            top: widget.size * 0.06,
            child: const _FloatingChip(
              icon: Icons.phone_android_rounded,
              label: 'Flutter Specialist',
              color: AppColors.primary,
            ),
          ),

          // Floating Chip Top-Right
          Positioned(
            right: -widget.size * 0.04,
            top: widget.size * 0.18,
            child: const _FloatingChip(
              icon: Icons.bolt_rounded,
              label: 'Clean Code',
              color: AppColors.primarySoft,
            ),
          ),

          // Glassmorphic Name & Status Badge Bottom-Center
          Positioned(
            bottom: -widget.size * 0.04,
            child: AnimatedContainer(
              duration: AppTheme.fastDuration,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.card.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: _hovered ? AppColors.primary : AppColors.borderHover,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${AppConstants.name} • Flutter Developer',
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
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

class _FloatingChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _FloatingChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderHover),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 7),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  final Color color;

  const _WindowDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _CodeLine extends StatelessWidget {
  final double width;
  final Color color;
  final IconData icon;

  const _CodeLine({
    required this.width,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 8),
        Container(
          width: width,
          height: 7,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}

class _OrbitRingPainter extends CustomPainter {
  final Color color;

  _OrbitRingPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.68,
      height: size.height * 0.68,
    );
    canvas.drawOval(rect, paint);

    final dotPaint = Paint()..color = AppColors.primary;
    final top = Offset(rect.center.dx, rect.top + 2);
    final right = Offset(rect.right - 2, rect.center.dy);
    final bottom = Offset(rect.center.dx, rect.bottom - 2);
    final left = Offset(rect.left + 2, rect.center.dy);

    for (final point in [top, right, bottom, left]) {
      canvas.drawCircle(point, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitRingPainter oldDelegate) =>
      oldDelegate.color != color;
}
