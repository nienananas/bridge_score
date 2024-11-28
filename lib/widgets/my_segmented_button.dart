import 'package:flutter/material.dart';

class MySegmentedButton extends StatelessWidget {
  const MySegmentedButton({
    super.key,
    required this.segments,
    required this.function,
    required this.initialSelection,
  });

  final List<ButtonSegment<int>> segments;
  final Function(Set<int>) function;
  final Set<int> initialSelection;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        side: WidgetStateProperty.all(BorderSide(
            color: Theme.of(context).colorScheme.outline,
            style: BorderStyle.solid,
            width: 1)),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return Theme.of(context)
                .colorScheme
                .primary; // Highlighted color for selected segment
          }
          return Theme.of(context)
              .colorScheme
              .secondary; // Default background color for unselected segments
        }),
      ),
      segments: segments,
      selected: initialSelection,
      showSelectedIcon: false,
      onSelectionChanged: function,
    );
  }
}
