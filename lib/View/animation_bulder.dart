import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationBuilderScreen extends StatefulWidget {
  const AnimationBuilderScreen({super.key});

  @override
  State<AnimationBuilderScreen> createState() => _AnimationBuilderScreenState();
}

class _AnimationBuilderScreenState extends State<AnimationBuilderScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation_Builder'),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, Widget? widget) {
            return Transform.rotate(
                child: widget,
                angle: _animationController.value * 2.0 * math.pi);
          },
          child: const FlutterLogo(size: 250.0),
        ),
      ),
    );
  }
}
