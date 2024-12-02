import 'package:flutter/material.dart';

///
/// Page for the Bridge rules
///
class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headLineStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final style = theme.textTheme.displaySmall!
        .copyWith(color: theme.colorScheme.onPrimary);

    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: theme.colorScheme.primary,
          child: Column(
            children: [
              Text("Bridge-Abrechnungs-Regeln:", style: headLineStyle),
              Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: Text(
                          """Bei der Abrechnung ist allein die Anzahl der Stiche jeder Partei von Bedeutung. Punktwerte von Karten, die bei der Abrechnung relevant wären, gibt es nicht. Ein Spiel ist vom Alleinspieler gewonnen, wenn er mindestens so viel Stiche macht wie im Kontrakt, d. h. im letzten abgegebenen Gebot, versprochen. Zusätzliche Stiche heißen Überstiche. Macht er weniger Stiche, dann gewinnt die Gegenpartei. In diesem Fall wird die Differenz zwischen angesagter Stichzahl und tatsächlich gemachter Stichzahl Faller genannt.
                      Zusätzlich gibt es das Konzept der Gefahrenlage (engl. vulnerability). Eine Partei kann entweder in Gefahr oder nicht in Gefahr sein. Vier Konstellationen sind möglich.
                      keine Partei in Gefahr, Nord-Süd in Gefahr, OW in Gefahr, beide Parteien in Gefahr
                      In Gefahr erhöhen sich sowohl die Prämien für gewonnene Spiele als auch die Strafen für verlorene Spiele. Für die Abrechnung ist nur die Gefahrenlage der Partei des Alleinspielers relevant. Bei Turnieren ergibt sich die Gefahrenlage aus der Nummer der gespielten Partie, beim Rubberbridge aus den bisher erzielten Punkten.
                      Die Situation, in der die eigene Partei nicht in Gefahr ist, während die Gegenpartei in Gefahr ist, wird auch als günstige Gefahrenlage bezeichnet. In günstiger Gefahrenlage ist es üblich beim Reizen etwas mehr zu riskieren und häufiger Opferspiele (siehe dort) zu reizen. Demgegenüber steht die ungünstige Gefahrenlage bei eigener Gefahr und gegnerischer Nichtgefahr, bei der ggf. etwas zurückhaltender gereizt werden sollte.""",
                          style: style)))
            ],
          ),
        ),
      );
    });
  }
}