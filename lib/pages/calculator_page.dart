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

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SegmentedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.selected)) {
                  return Theme.of(context)
                      .colorScheme
                      .primary; // Highlighted color for selected segment
                }
                return Theme.of(context)
                    .colorScheme
                    .secondary; // Default background color for unselected segments
              }),
              //WidgetStatePropertyAll(
              //Theme.of(context).colorScheme.primary)),
            ),
            segments: colourSegments,
            selected: {appState.colour.index},
            showSelectedIcon: false,
            onSelectionChanged: updateSelectedColour,
          ),
          const SizedBox(height: 10),
          SegmentedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.resolveWith<Color?>((states) {
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
            label: "Angesagt:",
          )

        ],
      ),
    );
  }
}
