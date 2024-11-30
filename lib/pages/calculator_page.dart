import 'package:bridge_score/widgets/bordered_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/data.dart';
import '../main.dart';
import '../model/evaluator.dart';
import '../widgets/discrete_slider.dart';
import '../widgets/my_segmented_button.dart';

class CalculatorPage extends StatefulWidget {
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.evaluate();
    appState.rollDanger();

    void updateSelectedColour(Set<int> selected) {
      HapticFeedback.vibrate();
      setState(() {
        appState.colour = Colour.values[selected.first];
        appState.evaluate();
      });
    }

    void updateSelectedMultiplier(Set<int> selected) {
      HapticFeedback.vibrate();
      setState(() {
        appState.multiplier = Multiplier.values[selected.first];
        appState.evaluate();
      });
    }

    var colourSegments = Colour.values
        .map((c) => ButtonSegment(
            icon: Icon(c.icon, color: c.color),
            label:
                (MediaQuery.sizeOf(context).width >= 800) ? Text(c.name) : null,
            value: c.index))
        .toList();

    var multiplierSegments = Multiplier.values
        .map((m) => ButtonSegment(label: Text(m.symbol), value: m.index))
        .toList();

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BorderedBox(children: [
              const SizedBox(height: 10),
              DiscreteSlider(
                moved: (value) =>
                    {appState.setCalled(value), appState.evaluate()},
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
                  function: updateSelectedColour,
                  initialSelection: {appState.colour.index},
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: MySegmentedButton(
                  segments: multiplierSegments,
                  initialSelection: {appState.multiplier.index},
                  function: updateSelectedMultiplier,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: appState.danger,
                      onChanged: (newDanger) {
                        HapticFeedback.vibrate();
                        if (newDanger == null) return;
                        appState.toggleDanger(newDanger);
                        appState.evaluate();
                      }),
                  const SizedBox(height: 10),
                  Text("In Gefahr ",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              DiscreteSlider(
                moved: (value) =>
                    {appState.setMade(value), appState.evaluate()},
                value: appState.made.toDouble(),
                min: 0,
                max: 13,
                label: "Gemacht",
              ),
            ]),
            BorderedBox(
              children: [
                Text(
                  (appState.currentResult == null)
                      ? "Gib deine Daten ein"
                      : "Ergebnis: ${appState.currentResult}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                ElevatedButton(
                    onPressed: appState.evaluate, child: Text("Ergebnis")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
