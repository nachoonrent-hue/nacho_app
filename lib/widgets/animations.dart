import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Fade + slide-up entrance used to stagger content into view.
class Entrance extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration duration;
  final double offset;

  const Entrance({
    super.key,
    required this.child,
    this.index = 0,
    this.duration = AppMotion.medium,
    this.offset = 14,
  });

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    final delay = Duration(milliseconds: widget.index * 70);
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();
    final curved = CurvedAnimation(
      parent: _controller,
      curve: AppMotion.entrance,
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.offset / 100),
      end: Offset.zero,
    ).animate(curved);

    if (delay > Duration.zero) {
      _controller.stop();
      Future<void>.delayed(delay).then((_) {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

/// Gives tappable widgets a tactile spring-like press feedback.
/// Uses a raw [Listener] so it never interferes with the child's own
/// gesture recognizers (InkWell / GestureDetector).
class PressableScale extends StatefulWidget {
  final Widget child;
  final double pressedScale;
  final double releasedScale;
  final Duration duration;

  const PressableScale({
    super.key,
    required this.child,
    this.pressedScale = 0.97,
    this.releasedScale = 1.0,
    this.duration = AppMotion.fast,
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) {
      setState(() => _pressed = value);
    }
  }

  bool _isWithinBounds(PointerEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return false;
    return box.size.contains(event.localPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) => _setPressed(true),
      onPointerUp: (e) {
        if (_isWithinBounds(e)) _setPressed(false);
      },
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        duration: widget.duration,
        curve: Curves.easeOut,
        scale: _pressed ? widget.pressedScale : widget.releasedScale,
        child: widget.child,
      ),
    );
  }
}

/// Counts-up a numeric value when it first appears on screen.
class AnimatedStat extends StatefulWidget {
  final double value;
  final int decimals;
  final Duration duration;
  final Duration delay;
  final TextStyle style;

  const AnimatedStat({
    super.key,
    required this.value,
    this.decimals = 0,
    this.duration = const Duration(milliseconds: 900),
    this.delay = const Duration(milliseconds: 200),
    this.style = const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  });

  @override
  State<AnimatedStat> createState() => _AnimatedStatState();
}

class _AnimatedStatState extends State<AnimatedStat>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _value;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    if (widget.delay > Duration.zero) {
      Future<void>.delayed(widget.delay).then((_) {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.forward();
    }

    _value = Tween<double>(
      begin: 0,
      end: widget.value,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void didUpdateWidget(covariant AnimatedStat oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value =
          Tween<double>(
            begin: widget.decimals > 0
                ? _controller.value * oldWidget.value
                : 0,
            end: widget.value,
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
          );
      _controller.forward(from: _controller.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _value,
      builder: (context, _) {
        final formatted = widget.decimals > 0
            ? _value.value.toStringAsFixed(widget.decimals)
            : _value.value.round().toString();
        return Text(formatted, style: widget.style);
      },
    );
  }
}

/// Soft breathing scale used for ambient highlights (dots, glows).
class Pulse extends StatelessWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final Duration duration;

  const Pulse({
    super.key,
    required this.child,
    this.minScale = 0.9,
    this.maxScale = 1.1,
    this.duration = const Duration(milliseconds: 1400),
  });

  @override
  Widget build(BuildContext context) {
    return _PulseStateful(
      minScale: minScale,
      maxScale: maxScale,
      duration: duration,
      child: child,
    );
  }
}

class _PulseStateful extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final Duration duration;

  const _PulseStateful({
    required this.child,
    required this.minScale,
    required this.maxScale,
    required this.duration,
  });

  @override
  State<_PulseStateful> createState() => _PulseStatefulState();
}

class _PulseStatefulState extends State<_PulseStateful>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0,
      upperBound: math.pi * 2,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = (math.sin(_controller.value) + 1) / 2;
        final scale = widget.minScale + (widget.maxScale - widget.minScale) * t;
        return Transform.scale(scale: scale, child: child);
      },
      child: widget.child,
    );
  }
}
