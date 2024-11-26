import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiscreteSlider extends StatelessWidget {
  const DiscreteSlider(
      {super.key,
      required this.moved,
      required this.value,
      required this.min,
      required this.max,
      required this.label});

  final Function(double) moved;
  final double value;
  final int min;
  final int max;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$label: ${value.toInt()}"),
        Slider(
            value: value,
            divisions: max - min,
            min: min.toDouble(),
            max: max.toDouble(),
            onChanged: (value) {
              HapticFeedback.vibrate();
              moved(value);
            }),
      ],
    );
  }
}
