// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:car_manager_app/results.dart';
import 'package:flutter/material.dart';
import 'package:car_manager_app/loading_results.dart';

class LapsTable extends StatefulWidget {
  const LapsTable({super.key});

  @override
  State<LapsTable> createState() => _LapsTableState();
}

class _LapsTableState extends State<LapsTable> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Qualifyng Results"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return const ResultsPage();
                },
              ));
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Center(
          child: Table(
            border: TableBorder.all(),
            // ignore: prefer_const_literals_to_create_immutables
            columnWidths: {
              0: const FractionColumnWidth(0.15),
              1: const FractionColumnWidth(0.50),
              2: const FractionColumnWidth(0.35),
            },
            children: [
              buildRow([
                "Lap",
                "Time",
                "Gap",
              ], isHeader: true),
              buildRow([
                laps1[0].execution_num.toString(),
                convert(laps1[0].time),
                "--",
              ]),
              buildRow([
                laps1[1].execution_num.toString(),
                convert(laps1[1].time),
                "+" + convert(laps1[1].time - laps1[0].time),
              ]),
              buildRow([
                laps1[2].execution_num.toString(),
                convert(laps1[2].time),
                "+" + convert(laps1[2].time - laps1[0].time),
              ]),
            ],
          ),
        ),
      );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
          children: cells.map((cell) {
        final style = TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 18,
        );
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
              child: Text(
            cell,
            style: style,
          )),
        );
      }).toList());

  String convert(int milliseconds) {

    String padding_milli = "";
    String padding_sec = "";

    Duration duration = Duration(milliseconds: milliseconds);
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds - minutes * 60;
    if (seconds < 10) {
      padding_sec = "0";
    }
    int millisecond =
        duration.inMilliseconds - (seconds * 1000) - (minutes * 60 * 1000);
    if (milliseconds < 100) {
      padding_milli = "0";
    }
    String time = minutes.toString() +
        ":" +
        padding_sec +
        seconds.toString() +
        "." +
        padding_milli +
        millisecond.toString();
    return time;
  }

}
