import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../core/constants/app_constants.dart';

class InteractiveBackground extends StatefulWidget {
  final int particleCount;

  final double glowIntensity;

  final double animationSpeed;

  final double interactionRadius;

  final double opacity;

  final Color accentColor;

  final Widget? child;

  const InteractiveBackground({
    super.key,
    this.particleCount = 40,
    this.glowIntensity = 0.5,
    this.animationSpeed = 1.0,
    this.interactionRadius = 180,
    this.opacity = 0.5,
    this.accentColor = AppColors.primary,
    this.child,
  });

  @override
  State<InteractiveBackground> createState() => _InteractiveBackgroundState();
}

class _InteractiveBackgroundState extends State<InteractiveBackground>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  late final List<_Particle> _particles;
  final math.Random _random = math.Random();

  final ValueNotifier<_MouseState> _mouseState = ValueNotifier(
    const _MouseState(position: Offset.zero, active: false),
  );

  Offset _targetMouse = Offset.zero;
  Offset _currentMouse = Offset.zero;
  bool _hasMouse = false;
  bool _isDesktop = false;
  Duration _lastElapsed = Duration.zero;
  double _time = 0;

  @override
  void initState() {
    super.initState();
    _isDesktop =
        kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;

    _particles = List.generate(widget.particleCount, (_) {
      return _Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: 1.5 + _random.nextDouble() * 2.5,
        speed: 0.2 + _random.nextDouble() * 0.6,
        drift: _random.nextDouble() * math.pi * 2,
        opacity: 0.15 + _random.nextDouble() * 0.35,
      );
    });

    _ticker = createTicker(_onTick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _mouseState.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    final dt = _lastElapsed == Duration.zero
        ? 0.016
        : (elapsed - _lastElapsed).inMicroseconds / 1e6;
    _lastElapsed = elapsed;

    final cycleSeconds = 20.0 / widget.animationSpeed;
    _time = (_time + dt / cycleSeconds) % 1.0;

    if (_hasMouse) {
      final t = (1 - math.pow(0.001, dt)).toDouble().clamp(0.0, 1.0);
      _currentMouse =
          Offset.lerp(_currentMouse, _targetMouse, t) ?? _currentMouse;
    }

    _mouseState.value = _MouseState(
      position: _currentMouse,
      active: _hasMouse && _isDesktop,
      time: _time,
    );
  }

  void _updateMouse(Offset globalPosition) {
    if (!_isDesktop) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    _targetMouse = box.globalToLocal(globalPosition);
    if (!_hasMouse) {
      _currentMouse = _targetMouse;
      _hasMouse = true;
    }
  }

  void _clearMouse() {
    _hasMouse = false;
  }

  @override
  Widget build(BuildContext context) {
    final paintLayer = RepaintBoundary(
      child: CustomPaint(
        painter: _InteractiveBackgroundPainter(
          mouseState: _mouseState,
          particles: _particles,
          glowIntensity: widget.glowIntensity,
          interactionRadius: widget.interactionRadius,
          opacity: widget.opacity,
          accentColor: widget.accentColor,
        ),
        child: const SizedBox.expand(),
      ),
    );

    final stack = Stack(
      children: [
        Positioned.fill(child: IgnorePointer(child: paintLayer)),
        if (widget.child != null) widget.child!,
      ],
    );

    if (!_isDesktop) {
      return stack;
    }
    return MouseRegion(
      onExit: (_) => _clearMouse(),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerHover: (event) => _updateMouse(event.position),
        onPointerMove: (event) => _updateMouse(event.position),
        child: stack,
      ),
    );
  }
}

class _MouseState {
  final Offset position;
  final bool active;
  final double time;

  const _MouseState({
    required this.position,
    required this.active,
    this.time = 0,
  });
}

class _Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double drift;
  final double opacity;

  const _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.drift,
    required this.opacity,
  });
}

class _InteractiveBackgroundPainter extends CustomPainter {
  final ValueNotifier<_MouseState> mouseState;
  final List<_Particle> particles;
  final double glowIntensity;
  final double interactionRadius;
  final double opacity;
  final Color accentColor;

  _InteractiveBackgroundPainter({
    required this.mouseState,
    required this.particles,
    required this.glowIntensity,
    required this.interactionRadius,
    required this.opacity,
    required this.accentColor,
  }) : super(repaint: mouseState);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    if (w <= 0 || h <= 0) return;

    final state = mouseState.value;
    final t = state.time;
    final mouse = state.position;
    final hasMouse = state.active;

    final gradientCenter = Alignment(
      math.sin(t * 2 * math.pi) * 0.35,
      math.cos(t * 2 * math.pi) * 0.35,
    );
    final basePaint = Paint()
      ..shader = RadialGradient(
        center: gradientCenter,
        radius: 1.3,
        colors: [
          accentColor.withValues(alpha: 0.06 * opacity),
          AppColors.background.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), basePaint);

    final glowCenter = hasMouse
        ? mouse
        : Offset(
            w * (0.5 + math.sin(t * 2 * math.pi) * 0.25),
            h * (0.5 + math.cos(t * 2 * math.pi) * 0.25),
          );

    final glowRadius =
        math.min(w, h) * (0.32 + 0.05 * math.sin(t * 2 * math.pi));
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          accentColor.withValues(alpha: 0.18 * glowIntensity * opacity),
          accentColor.withValues(alpha: 0.07 * glowIntensity * opacity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: glowCenter, radius: glowRadius));
    canvas.drawCircle(glowCenter, glowRadius, glowPaint);

    final secondaryCenter = Offset(
      w * (0.5 + math.cos(t * 2 * math.pi + 1.2) * 0.3),
      h * (0.5 + math.sin(t * 2 * math.pi + 1.2) * 0.3),
    );
    final secondaryRadius = math.min(w, h) * 0.2;
    final secondaryPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              accentColor.withValues(alpha: 0.08 * glowIntensity * opacity),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(center: secondaryCenter, radius: secondaryRadius),
          );
    canvas.drawCircle(secondaryCenter, secondaryRadius, secondaryPaint);

    final particlePaint = Paint();
    for (final p in particles) {
      final px =
          (p.x * w + math.sin(t * 2 * math.pi * p.speed + p.drift) * 20) % w;
      final py =
          (p.y * h + math.cos(t * 2 * math.pi * p.speed * 0.7 + p.drift) * 20) %
          h;

      var finalX = px;
      var finalY = py;
      if (hasMouse) {
        final dx = px - mouse.dx;
        final dy = py - mouse.dy;
        final dist = math.sqrt(dx * dx + dy * dy);
        if (dist < interactionRadius && dist > 0.1) {
          final push = (1 - dist / interactionRadius) * 22;
          finalX = px + (dx / dist) * push;
          finalY = py + (dy / dist) * push;
        }
      }

      particlePaint.color = accentColor.withValues(alpha: p.opacity * opacity);
      canvas.drawCircle(Offset(finalX, finalY), p.size, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _InteractiveBackgroundPainter oldDelegate) {
    return oldDelegate.opacity != opacity ||
        oldDelegate.glowIntensity != glowIntensity ||
        oldDelegate.interactionRadius != interactionRadius ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.mouseState != mouseState;
  }
}
