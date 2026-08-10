import 'package:flutter/material.dart';

class ScrollRevealScope extends InheritedWidget {
  final ScrollController controller;

  const ScrollRevealScope({
    super.key,
    required this.controller,
    required super.child,
  });

  static ScrollRevealScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ScrollRevealScope>();

  @override
  bool updateShouldNotify(ScrollRevealScope oldWidget) =>
      controller != oldWidget.controller;
}

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double offset;
  final Axis axis;
  final Duration duration;

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 32,
    this.axis = Axis.vertical,
    this.duration = const Duration(milliseconds: 850),
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _translation;
  late final Animation<double> _scale;

  ScrollController? _scrollController;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    const smoothCurve = Cubic(0.16, 1.0, 0.3, 1.0);

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );

    _translation = Tween<double>(
      begin: widget.offset,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: smoothCurve));

    _scale = Tween<double>(
      begin: 0.96,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: smoothCurve));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _attachToScroll();
      _checkVisibility();
    });
  }

  void _attachToScroll() {
    final scope = ScrollRevealScope.maybeOf(context);
    if (scope == null || _scrollController != null) return;
    _scrollController = scope.controller;
    _scrollController!.addListener(_checkVisibility);
  }

  void _checkVisibility() {
    if (_revealed || !mounted) return;

    final renderObject = context.findRenderObject() as RenderBox?;
    if (renderObject == null || !renderObject.hasSize) return;

    if (_scrollController == null || !_scrollController!.hasClients) {
      _reveal();
      return;
    }

    final viewportHeight = _scrollController!.position.viewportDimension;
    final itemTop = renderObject.localToGlobal(Offset.zero).dy;

    if (itemTop < viewportHeight * 0.92) {
      _reveal();
    }
  }

  void _reveal() {
    if (_revealed || !mounted) return;
    _revealed = true;
    _scrollController?.removeListener(_checkVisibility);

    if (widget.delay == Duration.zero) {
      if (mounted) _controller.forward();
    } else {
      Future<void>.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: AnimatedBuilder(
        animation: _translation,
        builder: (context, child) {
          final dy = widget.axis == Axis.vertical ? _translation.value : 0.0;
          final dx = widget.axis == Axis.horizontal ? _translation.value : 0.0;
          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.scale(scale: _scale.value, child: child),
          );
        },
        child: widget.child,
      ),
    );
  }
}
