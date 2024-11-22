import 'package:bridge_score/data.dart';
import 'package:bridge_score/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var colour = Colour.club;
  var multiplier = Multipliers.no;
  var danger = false;
  var called = 1;
  var made = 7;

  void toggleDanger(bool newDanger) {
    danger = newDanger;
    notifyListeners();
  }

  void setCalled(int value) {
    called = value;
    notifyListeners();
  }
}
