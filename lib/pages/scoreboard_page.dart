import 'package:bridge_score/main.dart';
import 'package:bridge_score/model/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoreboardPage extends StatelessWidget {
  const ScoreboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    ScoreboardEntry(
                      firstColumnText: Team.ns.name,
                      secondColumnText: Team.ow.name,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    ScoreboardEntry(
                      firstColumnText: appState.score.nsScore.toString(),
                      secondColumnText: appState.score.owScore.toString(),
                    )
                  ] +
                  (appState.oldScores.reversed
                      .map((oldScore) => ScoreboardEntry(
                            firstColumnText: "${oldScore.score.nsScore}",
                            secondColumnText: "${oldScore.score.owScore}",
                          ))
                      .toList()),
            ),
          ),
        ],),
      ),
    );
  }
}

class ScoreboardEntry extends StatelessWidget {
  const ScoreboardEntry({
    super.key,
    required this.firstColumnText,
    required this.secondColumnText,
  });

  final String firstColumnText;
  final String secondColumnText;

  final double rowHeight = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: rowHeight,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(firstColumnText),
                ),
              ),
            ),
            Container(
              color: Colors.black,
              width: 2,
              height: rowHeight,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: rowHeight,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(secondColumnText),
                ),
              ),
            ),
          ],
        ),
        const Divider(
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
