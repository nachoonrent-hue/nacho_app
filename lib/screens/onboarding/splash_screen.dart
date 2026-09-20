import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _pulseController;

  late final Animation<double> _markScale;
  late final Animation<double> _markFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _taglineFade;
  late final Animation<double> _dotsFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    );

    final markCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: AppMotion.spring),
    );
    _markScale = Tween<double>(begin: 0.4, end: 1.0).animate(markCurve);
    _markFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );

    final titleCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.62, curve: AppMotion.entrance),
    );
    _titleFade = titleCurve;
    _titleSlide = Tween<Offset>(begin: const Offset(0, -0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.35, 0.62, curve: AppMotion.entrance),
          ),
        );

    _taglineFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 0.80, curve: Curves.easeOut),
    );
    _taglineSlide =
        Tween<Offset>(begin: const Offset(0, 0.14), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.55, 0.80, curve: AppMotion.entrance),
          ),
        );

    _dotsFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.72, 0.95, curve: Curves.easeOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _controller.forward();

    Future<void>.delayed(const Duration(milliseconds: 2600), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const WelcomeScreen(),
            transitionsBuilder: (_, animation, _, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.05),
                    end: Offset.zero,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPlum,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Ambient gradient depth
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.3, -0.4),
                radius: 1.4,
                colors: [
                  Color(0xFF7B287E),
                  AppColors.primaryPlum,
                  Color(0xFF370F39),
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),
          // Dreamy decorative orbs
          Positioned(
            top: -90,
            right: -70,
            child: _Orb(
              size: 220,
              color: AppColors.saffron.withValues(alpha: 0.14),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -90,
            child: _Orb(size: 280, color: Colors.white.withValues(alpha: 0.05)),
          ),
          Positioned(
            bottom: 180,
            right: -60,
            child: _Orb(
              size: 140,
              color: AppColors.saffronAccent.withValues(alpha: 0.09),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 148,
                  height: 148,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _PulseRing(controller: _pulseController, phase: 0.0),
                      _PulseRing(controller: _pulseController, phase: 0.5),
                      FadeTransition(
                        opacity: _markFade,
                        child: ScaleTransition(
                          scale: _markScale,
                          child: Container(
                            width: 104,
                            height: 104,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.saffron,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.saffronAccent.withValues(
                                    alpha: 0.45,
                                  ),
                                  blurRadius: 30,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.celebration_rounded,
                              size: 54,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                FadeTransition(
                  opacity: _titleFade,
                  child: SlideTransition(
                    position: _titleSlide,
                    child: const Column(
                      children: [
                        Text(
                          'NACHOONRENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3.5,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 12,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeTransition(
                  opacity: _taglineFade,
                  child: SlideTransition(
                    position: _taglineSlide,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 24,
                          height: 1,
                          color: AppColors.saffronAccent.withValues(alpha: 0.7),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Celebrate. Connect. Experience.',
                            style: TextStyle(
                              color: AppColors.saffronAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 1,
                          color: AppColors.saffronAccent.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                FadeTransition(
                  opacity: _dotsFade,
                  child: _LoadingDots(animation: _pulseController, count: 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;

  const _Orb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _PulseRing extends StatelessWidget {
  final AnimationController controller;
  final double phase;

  const _PulseRing({required this.controller, required this.phase});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final t = Curves.easeOutCubic.transform(
          ((controller.value + phase) % 1.0),
        );
        return Transform.scale(
          scale: 0.85 + t * 0.75,
          child: Opacity(
            opacity: (1 - t) * 0.55,
            child: Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.saffron.withValues(alpha: 0.6),
                  width: 1.6,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadingDots extends StatelessWidget {
  final AnimationController animation;
  final int count;

  const _LoadingDots({required this.animation, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        return _Dot(animation: animation, index: index);
      }),
    );
  }
}

class _Dot extends StatelessWidget {
  final AnimationController animation;
  final int index;

  const _Dot({required this.animation, required this.index});

  @override
  Widget build(BuildContext context) {
    final stagger = index / 3.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final t = (animation.value + stagger) % 1.0;
          final wave = (math.sin(t * math.pi * 2) + 1) / 2;
          final scale = 0.6 + wave * 0.7;
          return Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: 0.5 + wave * 0.5,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.saffronAccent,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
