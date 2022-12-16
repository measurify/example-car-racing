// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_constructors, sort_child_properties_last, avoid_function_literals_in_foreach_calls, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings, avoid_print
import 'package:car_manager_app/cars/car01.dart';
import 'package:car_manager_app/samples.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:car_manager_app/loading_charts.dart';

import '../cars_new.dart';
import '../main.dart';

class SpeedChart extends StatefulWidget {
  const SpeedChart({Key? key}) : super(key: key);

  @override
  State<SpeedChart> createState() => _SpeedChartState();
}

class _SpeedChartState extends State<SpeedChart> {
  @override
  Widget build(BuildContext context) {
    laps.sort((a, b) => a.execution_num.compareTo(b.execution_num));
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Car 0" + target.toString() + " Telemetry"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            setState(() {
              datafiltered_speed = [];
              datafiltered_acc = [];
            });
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
                        datafiltered_speed = [];
                        setState(() {
                          //filterdata(speed_data, laps[0].start_time, laps[0].end_time);
                          datafiltered_speed = speed_data;
                          datafiltered_acc = acc_data;
                          //filterdata2(speed_data);
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Lap 1"),
                      value: 1,
                      onTap: () {
                        datafiltered_speed = [];
                        setState(() {
                          filterdata(
                              speed_data, laps[0].start_time, laps[0].end_time);
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Lap 2"),
                      value: 2,
                      onTap: () {
                        datafiltered_speed = [];
                        setState(() {
                          filterdata(
                              speed_data, laps[1].start_time, laps[1].end_time);
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Lap 3"),
                      value: 3,
                      onTap: () {
                        datafiltered_speed = [];
                        setState(() {
                          filterdata(
                              speed_data, laps[2].start_time, laps[2].end_time);
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
                spots: datafiltered_speed
                    .map((point) => FlSpot(point.milliseconds, point.speed))
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

  void filterdata(List<SpeedSamples> data, Duration t1, Duration t2) {
    print(data.length);
    data.forEach((element) {
      print(element.time.toString());
      if (element.time > t1 && element.time < t2) {
        datafiltered_speed.add(element);
      }
    });
    print(datafiltered_speed.toString());
    print(t1.toString());
    print(t2.toString());
  }

  void filterdata2(List<SpeedSamples> data) {
    data.forEach((element) {
      print(element.time.toString());
      if (element.speed != -1) {
        datafiltered_speed.add(element);
      }
    });
  }
}
