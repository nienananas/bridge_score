import 'dart:math';

import 'package:bridge_score/model/data.dart';
import 'package:bridge_score/model/evaluator.dart';
import 'package:bridge_score/pages/home_page.dart';
import 'package:bridge_score/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
  int currentResult = 0;

  var dangerSituation = DangerSituation.none;
  var currentTeam = Team.ns;
  var score = const Score(nsScore: 0, owScore: 0);
  List<ArchiveScore> oldScores = [];


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
    currentResult = Evaluator(
      colour: colour,
      multiplier: multiplier,
      called: called,
      made: made,
      danger: danger,
    ).evaluate();
    notifyListeners();
  }

  void updateScore() {
    evaluate();
    oldScores.add(ArchiveScore(score: score, danger: dangerSituation));
    if (currentTeam == Team.ns) {
      score = score.copyWith(nsScore: score.nsScore + currentResult);
    } else if (currentTeam == Team.ow) {
      score = score.copyWith(owScore: score.owScore + currentResult);
    }
    rollDanger();
    notifyListeners();
  }

  void rollBackScore() {
    var oldScore = oldScores.removeLast();
    score = oldScore.score;
    dangerSituation = oldScore.danger;
    notifyListeners();
  }

  void rollDanger() {
    dangerSituation = DangerSituation.values[Random().nextInt(4)];
    notifyListeners();
  }

  void changeTeams(Team team) {
    currentTeam = team;
    notifyListeners();
  }

  void resetGame() {
    score = const Score(nsScore: 0, owScore: 0);
    oldScores = [];
    dangerSituation = DangerSituation.none;
    notifyListeners();
  }
}
