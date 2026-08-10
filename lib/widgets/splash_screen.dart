import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;

  const SplashScreen({super.key, required this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  double _progress = 0.0;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _startLoading();
  }

  Future<void> _startLoading() async {
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(
        Duration(
          milliseconds: i < 25
              ? 12
              : i < 75
              ? 8
              : 14,
        ),
      );
      if (!mounted) return;
      setState(() {
        _progress = i / 100.0;
      });
    }

    await Future.delayed(const Duration(milliseconds: 250));
    if (!mounted) return;

    await _controller.forward();
    if (!mounted) return;

    setState(() {
      _completed = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_completed) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Scaffold(
                backgroundColor: AppColors.background,
                body: Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(
                                  alpha: 0.3 + (_progress * 0.3),
                                ),
                                blurRadius: 28 + (_progress * 18),
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              AppConstants.profilePhotoAsset,
                              width: 96,
                              height: 96,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        Text(
                          '${AppConstants.name.toLowerCase()}.dev',
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          AppConstants.role,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primarySoft,
                          ),
                        ),
                        const SizedBox(height: 36),

                        SizedBox(
                          width: 220,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: LinearProgressIndicator(
                                  value: _progress,
                                  minHeight: 6,
                                  backgroundColor: AppColors.card,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Loading portfolio...',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  Text(
                                    '${(_progress * 100).toInt()}%',
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
