import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Colour {
  club(
      icon: CupertinoIcons.suit_club,
      value: 20,
      name: "Treff",
      seventhValue: 20,
      color: Colors.black),
  diamonds(
      icon: CupertinoIcons.suit_diamond,
      value: 20,
      name: "Karo",
      seventhValue: 20,
      color: Colors.red),
  heart(
      icon: CupertinoIcons.suit_heart,
      value: 30,
      name: "Coeur",
      seventhValue: 30,
      color: Colors.red),
  spade(
      icon: CupertinoIcons.suit_spade,
      value: 30,
      name: "Pik",
      seventhValue: 30,
      color: Colors.black),
  noTrump(
      icon: CupertinoIcons.nosign,
      value: 30,
      name: "NT",
      seventhValue: 40,
      color: Colors.grey);

  const Colour({
    required this.value,
    required this.name,
    required this.seventhValue,
    required this.icon,
    required this.color,
  });

  final int value;
  final int seventhValue;
  final String name;
  final IconData icon;
  final Color color;
}

enum Multipliers {
  no(symbol: "Nichts", value: 1),
  contra(symbol: "Kontra", value: 2),
  re(symbol: "Re", value: 4);

  const Multipliers({
    required this.value,
    required this.symbol,
  });

  final int value;
  final String symbol;
}

class Evaluator {
  final Colour colour;
  final Multipliers multipliers;
  final int called;
  final int made;
  final bool danger;

  const Evaluator({
    required this.colour,
    required this.multipliers,
    required this.called,
    required this.made,
    required this.danger
  });

  int evaluate() {
    if (made >= called) {
    }
    return 0;
  }
}
