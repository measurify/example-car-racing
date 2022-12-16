// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, annotate_overrides, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:car_manager_app/home_page_new.dart';
import 'package:car_manager_app/cars_new.dart';

import 'samples.dart';

int currentPage = 0;

var token;
Car car01 = Car(id: 'Car 01', color: Colors.red);
Car car02 = Car(id: 'Car 02', color: Colors.black);
Car car03 = Car(id: 'Car 03', color: Colors.green);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  List<Widget> pages = const [HomePageNew(), CarsNew()];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qualifying Simulator App"),
      ),
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.drive_eta), label: "Cars"),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
