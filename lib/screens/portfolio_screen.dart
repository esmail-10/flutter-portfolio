import 'package:flutter/material.dart';

import '../core/responsive/responsive_utils.dart';
import '../core/utils/url_utils.dart';
import '../widgets/about_section.dart';
import '../widgets/common/scroll_reveal.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/journey_section.dart';
import '../widgets/navbar.dart';
import '../widgets/projects_section.dart';
import '../widgets/services_section.dart';
import '../widgets/skills_section.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _registerSectionKeys();
  }

  void _registerSectionKeys() {
    SectionController.instance
      ..register('home', _homeKey)
      ..register('about', _aboutKey)
      ..register('skills', _skillsKey)
      ..register('projects', _projectsKey)
      ..register('contact', _contactKey);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollRevealScope(
      controller: _scrollController,
      child: Scaffold(
        body: Scrollbar(
          controller: _scrollController,
          thumbVisibility: false,
          trackVisibility: false,
          child: PrimaryScrollController(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const Navbar(),

                  SizedBox(
                    key: _homeKey,
                    height: ResponsiveUtils.isMobile(context)
                        ? 960
                        : MediaQuery.sizeOf(context).width < 900
                        ? 960
                        : 720,
                    child: const HeroSection(),
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1440),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        key: _aboutKey,
                        width: double.infinity,
                        child: const AboutSection(),
                      ),
                    ),
                  ),

                  SizedBox(
                    key: _skillsKey,
                    width: double.infinity,
                    child: const SkillsSection(),
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1440),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        key: _projectsKey,
                        width: double.infinity,
                        child: const ProjectsSection(),
                      ),
                    ),
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1440),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: double.infinity,
                        child: const JourneySection(),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: const ServicesSection(),
                  ),

                  SizedBox(
                    key: _contactKey,
                    width: double.infinity,
                    child: const ContactSection(),
                  ),

                  const Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
