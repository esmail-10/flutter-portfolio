import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widgets/common/brand_icons.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/utils/url_utils.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.horizontalPadding(context),
        vertical: 32,
      ),
      child: Column(
        children: [
          if (!isMobile) ...[
            Row(
              children: [
                _Logo(),
                const Spacer(),
                for (final item in AppConstants.navItems) ...[
                  InkWell(
                    onTap: () => SectionController.instance.scrollTo(item),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Text(
                        item,
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),
            Container(height: 1, color: AppColors.border),
            const SizedBox(height: 24),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GitHubBrandIcon(
                tooltip: 'GitHub',
                url: AppConstants.githubUrl,
                size: 25,
              ),
              const SizedBox(width: 10),
              FacebookBrandIcon(
                tooltip: 'Facebook',
                url: AppConstants.facebookUrl,
                size: 25,
              ),
              const SizedBox(width: 10),
              LinkedInBrandIcon(
                tooltip: 'LinkedIn',
                url: AppConstants.linkedinUrl,
                size: 25,
              ),
              const SizedBox(width: 10),
              EmailIcon(tooltip: 'Email', email: AppConstants.email, size: 25),
              const SizedBox(width: 10),
              WhatsAppBrandIcon(
                tooltip: 'WhatsApp',
                url: UrlUtils.whatsappUrl(AppConstants.whatsappNumber),
                size: 25,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '© ${DateTime.now().year} ${AppConstants.name}. Built with Flutter & Dart.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            Icons.code_rounded,
            size: 17,
            color: AppColors.textOnPrimary,
          ),
        ),
        const SizedBox(width: 9),
        Text(
          'ismail.dev',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
