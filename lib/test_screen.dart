import 'package:flutter/material.dart';

import 'test_animation_1.dart';
import 'test_animation_2.dart';
import 'test_animation_3.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Test 1'),
              Tab(text: 'Test 2'),
              Tab(text: 'Test 3'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TestAnimation1(),
            TestAnimation2(),
            TestAnimation3(),
          ],
        ),
      ),
    );
  }
}
