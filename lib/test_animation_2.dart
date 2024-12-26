import 'package:flutter/material.dart';

class TestAnimation2 extends StatefulWidget {
  const TestAnimation2({super.key});

  @override
  State<TestAnimation2> createState() => _TestAnimation2State();
}

class _TestAnimation2State extends State<TestAnimation2>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetTween;
  late final Animation<double> _sizeTween;
  late final Animation<Color?> _colorTween;
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
      duration: const Duration(seconds: 2),
    );

    _offsetTween = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _sizeTween = Tween<double>(
      begin: 100,
      end: 150,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.25, 1)),
    );

    _colorTween = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.75, 1)),
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
