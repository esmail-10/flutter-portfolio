import 'package:flutter/material.dart';

/// Provides a [ScrollController] to descendant [ScrollReveal] widgets so they
/// can detect when they enter the viewport.
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

/// Reveals its child with a fade + slide animation when it enters viewport.
///
/// The animation triggers the first time the widget becomes visible inside
/// the scroll viewport (with an optional [delay]). It never re-triggers once
/// revealed. If no [ScrollRevealScope] ancestor exists, the widget animates
/// in immediately — useful for hero content on page load.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double offset;
  final Axis axis;

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 40,
    this.axis = Axis.vertical,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  ScrollController? _scrollController;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _offset = Tween<Offset>(
      begin: widget.axis == Axis.vertical
          ? Offset(0, widget.offset)
          : Offset(widget.offset, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

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

    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
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
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}
