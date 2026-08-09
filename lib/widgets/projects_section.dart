import 'package:flutter/material.dart';

import '../core/responsive/responsive_utils.dart';
import '../data/projects_data.dart';
import 'common/scroll_reveal.dart';
import 'common/section_header.dart';
import 'interactive_background.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return InteractiveBackground(
      particleCount: 35,
      glowIntensity: 0.45,
      animationSpeed: 0.9,
      interactionRadius: 170,
      opacity: 0.45,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: ResponsiveUtils.sectionVerticalPadding(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Portfolio',
              title: 'Featured Projects',
              subtitle:
                  'Some of the applications I\'ve designed and developed.',
            ),
            const SizedBox(height: 48),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = ResponsiveUtils.isMobile(context);
                final isTablet = ResponsiveUtils.isTablet(context);

                final projectWidth = isMobile
                    ? constraints.maxWidth
                    : isTablet
                    ? constraints.maxWidth
                    : (constraints.maxWidth - 24) / 2;

                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    for (final project in ProjectsData.projects)
                      ScrollReveal(
                        delay: const Duration(milliseconds: 100),
                        child: SizedBox(
                          width: projectWidth,
                          child: ProjectCard(project: project),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
