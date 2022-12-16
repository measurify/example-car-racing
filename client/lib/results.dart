// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:car_manager_app/app_button.dart';
import 'package:car_manager_app/loading_results.dart';
import 'package:car_manager_app/main.dart';
import 'package:flutter/material.dart';
import 'package:car_manager_app/laps_table.dart';


class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    //print(session);
    //print(session[0]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qualifyng Results"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return const MyApp();
              },
            ));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Table(
              border: TableBorder.all(),
              // ignore: prefer_const_literals_to_create_immutables
              columnWidths: {
                0: const FractionColumnWidth(0.15),
                1: const FractionColumnWidth(0.30),
                2: const FractionColumnWidth(0.30),
                3: const FractionColumnWidth(0.10),
                4: const FractionColumnWidth(0.15)
              },
              children: [
                buildRow(["Pos", "Car", "Time", "Lap", "Gap"], isHeader: true),
                buildRow([
                  "1",
                  session[0].car.id.toString(),
                  convert(session[0].laps[0].time),
                  session[0].laps[0].execution_num.toString(),
                  "---"
                ]),
                buildRow([
                  "2",
                  session[1].car.id.toString(),
                  convert(session[1].laps[0].time),
                  session[1].laps[0].execution_num.toString(),
                  "+" +
                      convert(session[1].laps[0].time - session[0].laps[0].time)
                ]),
                buildRow([
                  "3",
                  session[2].car.id.toString(),
                  convert(session[2].laps[0].time),
                  session[2].laps[0].execution_num.toString(),
                  "+" +
                      convert(session[2].laps[0].time - session[0].laps[0].time)
                ]),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  operation: 'Car 01',
                  description: '',
                  operationColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LapsTable();
                        },
                      ),
                    );
                  },
                ),
                AppButton(
                  operation: 'Car 02',
                  description: '',
                  operationColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LapsTable();
                        },
                      ),
                    );
                  },
                ),
                AppButton(
                  operation: 'Car 03',
                  description: '',
                  operationColor: Colors.green,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LapsTable();
                        },
                      ),
                    );
                  },
                ),
              ],
            )
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
