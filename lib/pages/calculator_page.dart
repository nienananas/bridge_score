import 'package:bridge_score/widgets/bordered_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/data.dart';
import '../main.dart';
import '../model/evaluator.dart';
import '../widgets/discrete_slider.dart';

class CalculatorPage extends StatefulWidget {
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    void updateSelectedColour(Set<int> selected) {
      HapticFeedback.vibrate();
      setState(() {
        appState.colour = Colour.values[selected.first];
      });
    }

    void updateSelectedMultiplier(Set<int> selected) {
      HapticFeedback.vibrate();
      setState(() {
        appState.multiplier = Multiplier.values[selected.first];
      });
    }

    var colourSegments = Colour.values
        .map((c) => ButtonSegment(
            icon: Icon(
              c.icon,
              color: c.color,
            ),
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
                      }),
                  const SizedBox(height: 10),
                  Text("In Gefahr ",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              DiscreteSlider(
                moved: appState.setMade,
                value: appState.made.toDouble(),
                min: 0,
                max: 13,
                label: "Gemacht",
              ),
            ]),
            ElevatedButton(
                child: Text("Ergebnis",
                    style: Theme.of(context).textTheme.bodyLarge),
                onPressed: () {
                  appState.evaluate();
                }),
            BorderedBox(
              children: [
                Text(
                  (appState.result == null)
                      ? "Gib deine Daten ein"
                      : "Ergebnis: ${appState.result}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MySegmentedButton extends StatelessWidget {
  const MySegmentedButton({
    super.key,
    required this.segments,
    required this.function,
    required this.initialSelection,
  });

  final List<ButtonSegment<int>> segments;
  final Function(Set<int>) function;
  final Set<int> initialSelection;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        side: WidgetStateProperty.all(BorderSide(
            color: Theme.of(context).colorScheme.outline,
            style: BorderStyle.solid,
            width: 1)),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return Theme.of(context)
                .colorScheme
                .primary; // Highlighted color for selected segment
          }
          return Theme.of(context)
              .colorScheme
              .secondary; // Default background color for unselected segments
        }),
      ),
      segments: segments,
      selected: initialSelection,
      showSelectedIcon: false,
      onSelectionChanged: function,
    );
  }
}
