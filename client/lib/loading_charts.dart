// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_build_context_synchronously, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:car_manager_app/cars/car01.dart';
import 'package:car_manager_app/cars/car02.dart';
import 'package:car_manager_app/loading_results.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:car_manager_app/samples.dart';
import 'cars/car03.dart';
import 'main.dart';
import "package:http/http.dart";
import 'package:car_manager_app/cars_new.dart';

List<SpeedSamples> speed_data = [];
List<AccSamples> acc_data = [];
List<String> time = [];
List<Lap> laps = [];
var numberofPosts_state;
double delta = 0;
String measurementUrl =
    'https:\\students.measurify.org/v1/measurements?filter={"feature": "state", "thing":"Car 0' +
        target.toString() +
        '"}&limit=1000&page=1';

class LoadinPage extends StatefulWidget {
  const LoadinPage({super.key});

  @override
  State<LoadinPage> createState() => _LoadinPageState();
}

class _LoadinPageState extends State<LoadinPage> {
  @override
  Widget build(BuildContext context) {
    speed_data = [];
    acc_data = [];
    time = [];
    laps = [];
    delta = 0;
    measurementUrl =
    'https:\\students.measurify.org/v1/measurements?filter={"feature": "state", "thing":"Car 0' +
        target.toString() +
        '"}&limit=1000&page=1';
    getNumberofPost(context);

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 10.0,
        ),
      ),
    );
  }

  void run(BuildContext context) async {
    var samples = [];
    for (int i = numberofPosts_state - 1; i >= 0; i--) {
      samples.add(await getSamples(i));
    }
    manageData(samples, context);
  }

  Future<dynamic> getSamples(int index) async {
    var url = Uri.parse(measurementUrl);

    Response response = await get(url, headers: {
      'Accept': 'application/json',
      'Authorization': token,
    });
    var body = json.decode(response.body);
    time.add(body["docs"][index]["startDate"]);
    body = body["docs"][index]["samples"];
    return body;
  }

  void manageData(var data, BuildContext context) async {
    for (int j = 0; j < data.length; j++) {
      for (int i = 0; i < data[j].length; i++) {
        double value_speed = data[j][i]["values"][0];
        double value_acc = data[j][i]["values"][1];
        speed_data.add(SpeedSamples(
            milliseconds: delta,
            speed: value_speed,
            time: convert(time[j].substring(11, 23))));
        acc_data.add(AccSamples(
            milliseconds: delta,
            acc: value_acc,
            time: convert(time[j].substring(11, 23))));
        delta = delta + 20.0;
      }
    }

    //Navigator.popAndPushNamed(context, '/Car01');
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        if (target == 1) {
          laps = laps1;
          return Car01();
        } else if (target == 2) {
          laps = laps2;
          return Car02();
        } else {
          laps = laps3;
          return Car03();
        }
      },
    ));
  }

  Future<dynamic> getNumberofPost(BuildContext context) async {
    var url = Uri.parse(measurementUrl);

    Response response = await get(url, headers: {
      'Accept': 'application/json',
      'Authorization': token,
    });
    var body = json.decode(response.body);
    numberofPosts_state = body['totalDocs'] as int;
    run(context);
  }

  Duration convert(String date) {
    int hour = int.parse(date.substring(0, 2));
    int minute = int.parse(date.substring(3, 5));
    int second = int.parse(date.substring(6, 8));
    int milli = int.parse(date.substring(9, 12));
    Duration time = Duration(
        hours: hour, minutes: minute, seconds: second, milliseconds: milli);
    return time;
  }
}
