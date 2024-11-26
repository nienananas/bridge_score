import 'dart:math';

import 'data.dart';

class Evaluator {
  final Colour colour;
  final Multiplier multiplier;
  final int called;
  final int made;
  final bool danger;

  const Evaluator(
      {required this.colour,
        required this.multiplier,
        required this.called,
        required this.made,
        required this.danger});

  int evaluate() {
    var result = 0;
    if (made >= called + 6) {
      //If won
      result = calculateWonGame();
    } else {
      int difference = called + 6 - made;
      result = -calculateLostGame(difference);
    }
    return result;
  }

  int calculateWonGame() {
    int calledReal = called + 6;
    int result = 0;

    //Stiche bis zur Ansage
    int calledPoints = colour.seventhValue * multiplier.value + colour.value * multiplier.value * (calledReal - 7);
    result += calledPoints;

    //Überstiche
    int overhead = max(made - calledReal, 0);

    result += overhead *
        switch ((multiplier, danger)) {
          (Multiplier.no, _) => colour.value * multiplier.value,
          (Multiplier.contra, false) => 100,
          (Multiplier.contra, true) => 200,
          (Multiplier.re, false) => 200,
          (Multiplier.re, true) => 400,
        };

    result += getBonus(calledPoints);
    return result;
  }

  int getBonus(int calledPoints) {
    int multiplierBonus = multiplier.bonus;

    if (calledPoints < 100) {
      //Teilkontrakt
      return multiplierBonus + 50;
    }

    if (called == 6) {
      //Kleinschlemm
      return multiplierBonus + (danger ? 1250 : 800);
    } else if (called == 7) {
      //Großschlemm
      return multiplierBonus + (danger ? 2000 : 1300);
    } else {
      //Vollspiel
      return multiplierBonus + (danger ? 500 : 300);
    }
  }

  int calculateLostGame(int difference) {
    if (difference == 1) {
      return 50 * multiplier.value * (danger ? 2 : 1);
    } else if (difference == 2) {
      return switch ((multiplier, danger)) {
        (Multiplier.no, false) => 100,
        (Multiplier.no, true) => 200,
        (Multiplier.contra, false) => 300,
        (Multiplier.contra, true) => 500,
        (Multiplier.re, false) => 600,
        (Multiplier.re, true) => 1000,
      };
    } else if (difference == 3) {
      return switch ((multiplier, danger)) {
        (Multiplier.no, false) => 150,
        (Multiplier.no, true) => 300,
        (Multiplier.contra, false) => 500,
        (Multiplier.contra, true) => 800,
        (Multiplier.re, false) => 1000,
        (Multiplier.re, true) => 1600,
      };
    } else {
      return calculateLostGame(3) +
          (difference - 3) *
              switch ((multiplier, danger)) {
                (Multiplier.no, false) => 50,
                (Multiplier.no, true) => 100,
                (Multiplier.contra, _) => 300,
                (Multiplier.re, _) => 600,
              };
    }
  }
}