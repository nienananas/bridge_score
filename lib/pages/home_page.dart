import 'package:bridge_score/pages/scoreboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'rules_page.dart';
import 'calculator_page.dart';
import 'danger_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = CalculatorPage();
        break;
      case 1:
        page = RulesPage();
        break;
      case 2:
        page = DangerPage();
        break;
      case 3:
        page = ScoreboardPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.calculate_outlined),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.text_snippet),
                    label: Text('Regeln'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(CupertinoIcons.burn),
                    label: Text('Gefahr'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.list_alt),
                    label: Text('Scoreboard'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
