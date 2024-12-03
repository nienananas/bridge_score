import 'dart:math';

import 'package:bridge_score/model/data.dart';
import 'package:bridge_score/model/evaluator.dart';
import 'package:bridge_score/pages/home_page.dart';
import 'package:bridge_score/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var called = 1;
  var made = 7;
  int currentResult = 70;

  var dangerSituation = DangerSituation.none;
  var currentTeam = Team.ns;
  var score = const Score(nsScore: 0, owScore: 0);
  List<ArchiveScore> oldScores = [];

  void setCalled(double value) {
    HapticFeedback.vibrate();
    called = value.round();
    evaluate();
    notifyListeners();
  }

  void setMade(double value) {
    HapticFeedback.vibrate();
    made = value.round();
    evaluate();
    notifyListeners();
  }

  void evaluate() {
    currentResult = Evaluator(
      colour: colour,
      multiplier: multiplier,
      called: called,
      made: made,
      danger: dangerSituation.dangeredParties.contains(currentTeam),
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
    if (oldScores.isEmpty) return;
    var oldScore = oldScores.removeLast();
    score = oldScore.score;
    dangerSituation = oldScore.danger;
    evaluate();
    notifyListeners();
  }

  void rollDanger() {
    dangerSituation = DangerSituation.values[Random().nextInt(4)];
    evaluate();
    notifyListeners();
  }

  void changeTeams(Team team) {
    currentTeam = team;
    evaluate();
    notifyListeners();
  }

  void resetGame() {
    HapticFeedback.vibrate();
    score = const Score(nsScore: 0, owScore: 0);
    oldScores = [];
    dangerSituation = DangerSituation.none;
    notifyListeners();
  }

  void updateSelectedColour(Set<int> selected) {
    HapticFeedback.vibrate();
    colour = Colour.values[selected.first];
    evaluate();
    notifyListeners();
  }

  void updateSelectedMultiplier(Set<int> selected) {
    HapticFeedback.vibrate();
    multiplier = Multiplier.values[selected.first];
    evaluate();
    notifyListeners();
  }
}
