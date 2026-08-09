import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_constants.dart';
import '../../core/responsive/responsive_utils.dart';

/// Reusable section header with eyebrow, title, and optional subtitle.
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool center;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          if (center)
            Center(child: _EyebrowBadge(text: eyebrow))
          else
            _EyebrowBadge(text: eyebrow),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: center ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.inter(
              fontSize: ResponsiveUtils.isMobile(context) ? 28 : 38,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                subtitle!,
                textAlign: center ? TextAlign.center : TextAlign.left,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EyebrowBadge extends StatelessWidget {
  final String text;

  const _EyebrowBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: AppColors.primarySoft,
            ),
          ),
        ],
      ),
    );
  }
}
