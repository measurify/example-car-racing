// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, sort_child_properties_last, prefer_const_constructors, avoid_function_literals_in_foreach_calls
import 'package:car_manager_app/cars/car01.dart';
import 'package:car_manager_app/samples.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:car_manager_app/loading_charts.dart';

import '../main.dart';

class AccChart extends StatefulWidget {
  const AccChart({super.key});

  @override
  State<AccChart> createState() => _AccChartState();
}

class _AccChartState extends State<AccChart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Car 01 Telemetry"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                currentPage = 1;
                return const MyApp();
              },
            ));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                      child: Text("COMPLETE TELEMETRY"),
                      value: 1,
                      onTap: () {
                        datafiltered_acc = [];
                        setState(() {
                          datafiltered_acc = acc_data;
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Lap 1"),
                      value: 1,
                      onTap: () {
                        datafiltered_acc = [];
                        setState(() {
                          //filterdata(acc_data, laps[0].start_time,laps[0].end_time);
                          datafiltered_acc = acc_data;
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Lap 2"),
                      value: 2,
                      onTap: () {
                        datafiltered_acc = [];
                        setState(() {
                          filterdata(
                              acc_data, laps[1].start_time, laps[1].end_time);
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Lap 3"),
                      value: 3,
                      onTap: () {
                        datafiltered_acc = [];
                        setState(() {
                          filterdata(
                              acc_data, laps[2].start_time, laps[2].end_time);
                        });
                      },
                    )
                  ])
        ],
      ),
      body: Center(
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: datafiltered_acc
                    .map((point) => FlSpot(point.milliseconds, point.acc))
                    .toList(),
                isCurved: false,
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void filterdata(List<AccSamples> data, Duration t1, Duration t2) {
    data.forEach((element) {
      if (element.time > t1 && element.time < t2) {
        datafiltered_acc.add(element);
      }
    });
  }
}
