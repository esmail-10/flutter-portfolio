import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/responsive/responsive_utils.dart';
import '../core/utils/url_utils.dart';

/// Simple footer with copyright and quick links.
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
              _FooterIcon(
                tooltip: 'GitHub',
                icon: Icons.code_rounded,
                url: AppConstants.githubUrl,
              ),
              const SizedBox(width: 10),
              _FooterIcon(
                tooltip: 'LinkedIn',
                icon: Icons.work_rounded,
                url: AppConstants.linkedinUrl,
              ),
              const SizedBox(width: 10),
              _FooterIcon(
                tooltip: 'Email',
                icon: Icons.mail_rounded,
                url: 'mailto:${AppConstants.email}',
              ),
              const SizedBox(width: 10),
              _FooterIcon(
                tooltip: 'WhatsApp',
                icon: Icons.chat_rounded,
                url: UrlUtils.whatsappUrl(AppConstants.whatsappNumber),
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
          child: const Icon(
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

class _FooterIcon extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final String url;

  const _FooterIcon({
    required this.tooltip,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => UrlUtils.open(url),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 17, color: AppColors.textSecondary),
      ),
    );
  }
}
