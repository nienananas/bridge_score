import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

///
/// Page for rolling a random danger value
///
class DangerPage extends StatefulWidget {
  @override
  State<DangerPage> createState() => _DangerPageState();
}

class _DangerPageState extends State<DangerPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimaryFixed,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
              "Gefahrensituation: ${appState.dangerSituation.label}",
              style: style,
            )),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: appState.rollDanger,
          child: const Text("Würfeln"),
        )
      ],
    );
  }
}