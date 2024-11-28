import 'package:flutter/material.dart';

class BorderedBox extends StatelessWidget {
  const BorderedBox({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          border: Border.all(width: 1.0, color: Theme.of(context).colorScheme.outline),
          borderRadius: const BorderRadius.all(
              Radius.circular(10.0) //                 <--- border radius here
              )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
