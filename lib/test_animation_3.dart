import 'package:flutter/material.dart';

class TestAnimation3 extends StatefulWidget {
  const TestAnimation3({super.key});

  @override
  State<TestAnimation3> createState() => _TestAnimation3State();
}

class _TestAnimation3State extends State<TestAnimation3>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _sizeTween;
  late final Animation<Color?> _colorTween;
  late final Animation<Offset> _offsetTween;
  late final Animation<BorderRadius?> _radiusTween;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _offsetTween = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, 0),
          end: const Offset(0, -1),
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, -1),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 0.5,
      ),
    ]).animate(_controller);

    _sizeTween = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 100, end: 150),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 150, end: 100),
        weight: 0.5,
      ),
    ]).animate(_controller);

    _colorTween = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.red, end: Colors.blue),
          weight: 0.25,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.blue, end: Colors.green),
          weight: 0.5,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.green, end: Colors.black),
          weight: 0.25,
        ),
      ],
    ).animate(_controller);
  
    _radiusTween = BorderRadiusTween(
      begin: BorderRadius.circular(0),
      end: BorderRadius.circular(200),
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SlideTransition(
                position: _offsetTween,
                child: Container(
                  width: _sizeTween.value,
                  height: _sizeTween.value,
                  decoration: BoxDecoration(
                    color: _colorTween.value,
                    borderRadius: _radiusTween.value,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _controller.forward(from: 0);
            },
            child: const Text('Animate'),
          ),
          const Row(),
        ],
      ),
    );
  }
}
