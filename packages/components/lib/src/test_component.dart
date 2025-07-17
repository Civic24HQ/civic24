import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

class TestComponent extends StatelessWidget {
  const TestComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.size16),
        child: Text(
          'Golden Test component',
          textAlign: TextAlign.center,
          style: TextStyle(color: context.surface, fontSize: AppDimensions.size16),
        ),
      ),
    );
  }
}
