import 'dart:math';

import 'package:flutter/material.dart';

///
/// Page for rolling a random danger value
///
class DangerPage extends StatefulWidget {
  @override
  State<DangerPage> createState() => _DangerPageState();
}

class _DangerPageState extends State<DangerPage> {
  var text = "Würfeln für Gefahr";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
              text,
              style: style,
            )),
        const SizedBox(height: 10),
        ElevatedButton(
          child: const Text("Würfeln"),
          onPressed: () {
            setState(() {
              var rand = Random().nextInt(4);
              text = [
                "Niemand in Gefahr",
                "NS in Gefahr",
                "OW in Gefahr",
                "Alle in Gefahr!"
              ][rand];
            });
          },
        )
      ],
    );
  }
}