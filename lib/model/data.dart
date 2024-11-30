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
      color: Colors.black);

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

enum Multiplier {
  no(symbol: "Nichts", value: 1, bonus: 0),
  contra(symbol: "Kontra", value: 2, bonus: 50),
  re(symbol: "Re", value: 4, bonus: 100);

  const Multiplier({
    required this.value,
    required this.symbol,
    required this.bonus,
  });

  final int value;
  final String symbol;
  final int bonus;
}

enum Team {
  ns(name: "Nord-Sus"),
  ow(name: "Ost-West");

  const Team({
    required this.name,
  });

  final String name;
}

enum DangerSituation {
  ns(dangeredParties: [Team.ns], label: "Nord-Sus in Gefahr"),
  ow(dangeredParties: [Team.ow], label: "OW in Gefahr"),
  all(dangeredParties: [Team.ns, Team.ow], label: "Alle in Gefahr"),
  none(dangeredParties: [], label: "Niemand in Gefahr");

  const DangerSituation({
    required this.dangeredParties,
    required this.label,
  });

  final List<Team> dangeredParties;
  final String label;
}

class ArchiveScore {
  const ArchiveScore({
    required this.score,
    required this.danger,
  });

  final Score score;
  final DangerSituation danger;
}

class Score {
  const Score({
    required this.nsScore,
    required this.owScore,
  });

  final int nsScore;
  final int owScore;

  Score copyWith({int? nsScore, int? owScore}) {
    return Score(
      nsScore: nsScore ?? this.nsScore,
      owScore: owScore ?? this.nsScore,
    );
  }
}
