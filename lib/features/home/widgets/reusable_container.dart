import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  const ReusableContainer({
    super.key,
    required this.child,
    this.color = const Color.fromARGB(255, 255, 175, 175),
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: color,
      padding: padding,
      child: child,
    );
  }
}
