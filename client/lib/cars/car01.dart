// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, override_on_non_overriding_member, non_constant_identifier_names, annotate_overrides, prefer_const_constructors, sort_child_properties_last, avoid_function_literals_in_foreach_calls


import 'package:car_manager_app/linecharts/acc_chart.dart';
import 'package:car_manager_app/samples.dart';
import 'package:flutter/material.dart';
import 'package:car_manager_app/linecharts/speed_chart.dart';

List<SpeedSamples> datafiltered_speed = [];
List<AccSamples> datafiltered_acc = [];

class Car01 extends StatefulWidget {
  const Car01({super.key});

  @override
  State<Car01> createState() => _Car01State();
}

class _Car01State extends State<Car01> {
  @override
  int currentPage_cars = 0;
  List<Widget> pages_cars = [SpeedChart(), AccChart()];
  Widget build(BuildContext context) {
    datafiltered_speed = [];
    datafiltered_acc = [];
    return Scaffold(
      body: pages_cars[currentPage_cars],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.area_chart_sharp), label: "Speed Chart"),
          NavigationDestination(
              icon: Icon(Icons.area_chart_sharp), label: "Acceleration Chart"),
        ],
        onDestinationSelected: (int indexCars) {
          setState(() {
            currentPage_cars = indexCars;
          });
        },
        selectedIndex: currentPage_cars,
      ),
    );
  }
}
