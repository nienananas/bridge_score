import 'package:bridge_score/model/data.dart';
import 'package:bridge_score/model/evaluator.dart';
import 'package:bridge_score/pages/home_page.dart';
import 'package:bridge_score/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//TODO: Abrechnung implementieren

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Bridge App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: MaterialTheme.lightScheme(),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var colour = Colour.club;
  var multiplier = Multiplier.no;
  var danger = false;
  var called = 1;
  var made = 7;
  int? result;

  void toggleDanger(bool newDanger) {
    danger = newDanger;
    notifyListeners();
  }

  void setCalled(double value) {
    called = value.round();
    notifyListeners();
  }

  void setMade(double value) {
    made = value.round();
    notifyListeners();
  }

  void evaluate() {
    result = Evaluator(
      colour: colour,
      multiplier: multiplier,
      called: called,
      made: made,
      danger: danger,
    ).evaluate();
    notifyListeners();
  }
}
