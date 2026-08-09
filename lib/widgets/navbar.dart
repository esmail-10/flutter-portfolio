import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/url_utils.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _scrolled = false;
  ScrollController? _scrollController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = PrimaryScrollController.maybeOf(context);
    _scrollController?.addListener(_onScroll);
    _onScroll();
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrollController = _scrollController;
    if (scrollController == null || !scrollController.hasClients) return;
    final shouldScroll = scrollController.offset > 24;
    if (shouldScroll != _scrolled && mounted) {
      setState(() => _scrolled = shouldScroll);
    }
  }

  void _navigate(String section) {
    SectionController.instance.scrollTo(section);
  }

  void _openMobileMenu() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.card,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderHover,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 20),
                for (final item in AppConstants.navItems) ...[
                  _MobileMenuLink(
                    label: item,
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _navigate(item);
                    },
                  ),
                  const SizedBox(height: 4),
                ],
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      UrlUtils.open(AppConstants.cvUrl);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textOnPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text('Download CV'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final showDesktopNav = MediaQuery.sizeOf(context).width >= 900;

    return AnimatedContainer(
      duration: AppTheme.fastDuration,
      curve: AppTheme.defaultCurve,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.horizontalPadding(context),
      ),
      height: showDesktopNav ? 72 : 64,
      decoration: BoxDecoration(
        color: _scrolled
            ? AppColors.background.withValues(alpha: 0.85)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _scrolled ? AppColors.border : Colors.transparent,
          ),
        ),
      ),
      child: Row(
        children: [
          _Logo(onTap: () => _navigate('Home')),
          const Spacer(),
          if (showDesktopNav) ...[
            for (final item in AppConstants.navItems)
              _NavLink(label: item, onTap: () => _navigate(item)),
            const SizedBox(width: 24),
            _DownloadCvButton(),
          ] else
            _MobileMenuButton(onTap: _openMobileMenu),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                AppConstants.profilePhotoAsset,
                width: 34,
                height: 34,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'ismail.dev',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: AppTheme.fastDuration,
          curve: AppTheme.defaultCurve,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
              color: _hovered ? AppColors.primarySoft : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _DownloadCvButton extends StatefulWidget {
  @override
  State<_DownloadCvButton> createState() => _DownloadCvButtonState();
}

class _DownloadCvButtonState extends State<_DownloadCvButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: () => UrlUtils.open(AppConstants.cvUrl),
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: AppTheme.fastDuration,
          curve: AppTheme.defaultCurve,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            gradient: _hovered
                ? const LinearGradient(
                    colors: [AppColors.primarySoft, AppColors.primary],
                  )
                : AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: 16,
                color: AppColors.textOnPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                'Download CV',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
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

class _MobileMenuButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MobileMenuButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: const Icon(
          Icons.menu_rounded,
          color: AppColors.textPrimary,
          size: 24,
        ),
      ),
    );
  }
}

class _MobileMenuLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _MobileMenuLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_forward_rounded,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
