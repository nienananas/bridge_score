import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../main.dart';
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
      setState(() {
        appState.colour = Colour.values[selected.first];
      });
    }

    void updateSelectedMultiplier(Set<int> selected) {
      setState(() {
        appState.multiplier = Multipliers.values[selected.first];
      });
    }

    var colourSegments = Colour.values
        .map((c) => ButtonSegment(
            /*
            label: LayoutBuilder(builder: (context, constraints) {
              return Offstage(offstage: constraints.maxWidth >= 600, child: Text(c.name),);
            }),*/
            icon: Icon(
              c.icon,
              color: c.color,
            ),
            value: c.index))
        .toList();

    var multiplierSegments = Multipliers.values
        .map((m) => ButtonSegment(label: Text(m.symbol), value: m.index))
        .toList();

    var buttonStyle = ButtonStyle(
      backgroundColor:
      WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return Theme.of(context)
              .colorScheme
              .primary; // Highlighted color for selected segment
        }
        return Theme.of(context)
            .colorScheme.secondary; // Default background color for unselected segments
      }),
    );

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton(
              style: buttonStyle,
              segments: colourSegments,
              selected: {appState.colour.index},
              showSelectedIcon: false,
              onSelectionChanged: updateSelectedColour,
            ),
            const SizedBox(height: 10),
            SegmentedButton(
              style: buttonStyle,
              segments: multiplierSegments,
              selected: {appState.multiplier.index},
              onSelectionChanged: updateSelectedMultiplier,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("In Gefahr"),
                Checkbox(
                    value: appState.danger,
                    onChanged: (newDanger) {
                      if (newDanger == null) return;

                      appState.toggleDanger(newDanger);
                    }),
              ],
            ),
            const SizedBox(height: 10),
            DiscreteSlider(
              moved: appState.setCalled,
              value: appState.called.toDouble(),
              min: 1,
              max: 7,
              label: "Angesagt",
            ),
            const SizedBox(height: 10),
            DiscreteSlider(
              moved: appState.setMade,
              value: appState.made.toDouble(),
              min: 1,
              max: 13,
              label: "Gemacht",
            ),
            const SizedBox(height: 20),
            Text((appState.result == null) ? "Gib deine Daten ein" : "Ergebnis: ${appState.result}"),
            ElevatedButton(
                child: const Text("Ergebnis"),
                onPressed: () {
                  var evaluator = Evaluator(
                    colour: appState.colour,
                    multipliers: appState.multiplier,
                    called: appState.called,
                    made: appState.made,
                    danger: appState.danger,
                  );

                  setState(() {
                    appState.setResult(evaluator.evaluate());
                  });
                }),
          ],
        ),
      ),
    );
  }
}
