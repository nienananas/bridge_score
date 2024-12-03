import 'package:bridge_score/widgets/bordered_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../model/data.dart';
import '../widgets/discrete_slider.dart';
import '../widgets/my_segmented_button.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    var textStyle = Theme.of(context).textTheme.bodyLarge;

    var colourSegments = Colour.values
        .map((c) => ButtonSegment(
            icon: Icon(c.icon, color: c.color),
            label:
                (MediaQuery.sizeOf(context).width >= 800) ? Text(c.name) : null,
            value: c.index))
        .toList();

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BorderedBox(children: [
              Text(
                "Gefahrensituation: ${appState.dangerSituation.label}",
                style: appState.dangerSituation.dangeredParties
                        .contains(appState.currentTeam)
                    ? textStyle!.copyWith(color: Colors.red, fontSize: 20)
                    : textStyle,
              )
            ]),
            //Teams Segmented Button
            MySegmentedButton(
              segments: Team.values
                  .map(
                      (t) => ButtonSegment(label: Text(t.name), value: t.index))
                  .toList(),
              function: (selected) =>
                  appState.changeTeams(Team.values[selected.first]),
              initialSelection: {appState.currentTeam.index},
            ),
            //Current game characteristics interface
            BorderedBox(children: [
              const SizedBox(height: 10),
              DiscreteSlider(
                moved: appState.setCalled,
                value: appState.called.toDouble(),
                min: 1,
                max: 7,
                label: "Angesagt",
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: MySegmentedButton(
                  segments: colourSegments,
                  function: appState.updateSelectedColour,
                  initialSelection: {appState.colour.index},
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: MySegmentedButton(
                  segments: Multiplier.values
                      .map((m) =>
                          ButtonSegment(label: Text(m.symbol), value: m.index))
                      .toList(),
                  initialSelection: {appState.multiplier.index},
                  function: appState.updateSelectedMultiplier,
                ),
              ),
              const SizedBox(height: 10),
              DiscreteSlider(
                moved: appState.setMade,
                value: appState.made.toDouble(),
                min: 0,
                max: 13,
                label: "Gemacht",
              ),
            ]),
            BorderedBox(
              children: [
                Text(
                  "Ergebnis: ${appState.currentResult}",
                  style: textStyle,
                ),
              ],
            ),
            BorderedBox(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: appState.updateScore,
                          child: const Text("Spiel eintragen")),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: appState.rollBackScore,
                        child: const Text("Spiel zurücknehmen"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: appState.resetGame,
                        child: const Text("Spiel zurücksetzen"),
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ],
            ),
            BorderedBox(
              children: [
                Text("${Team.ns.name}: ${appState.score.nsScore}",
                    style: textStyle),
                const SizedBox(height: 10),
                Text("${Team.ow.name}: ${appState.score.owScore}",
                    style: textStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
