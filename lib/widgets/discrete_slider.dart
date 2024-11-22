import 'package:flutter/material.dart';

class DiscreteSlider extends StatelessWidget {
  const DiscreteSlider({super.key,
    required this.moved,
    required this.value,
    required this.min,
    required this.max, required this.label});

  final Function(int) moved;
  final double value;
  final int min;
  final int max;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$label: $value"),
        Slider(
            value: value,
            divisions: max - min,
            min: min.toDouble(),
            max: min.toDouble(),
            onChanged: (value) {
              moved(value.round());
            }),
      ],
    );
  }
}