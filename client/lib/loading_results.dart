// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, use_build_context_synchronously, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables

import 'package:car_manager_app/results.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:car_manager_app/samples.dart';
import 'main.dart';
import "package:http/http.dart";

const String measurementUrl1 =
    'https:\\students.measurify.org/v1/measurements?filter={"feature": "check-point", "thing":"Car 01"}&limit=10&page=1';
const String measurementUrl2 =
    'https:\\students.measurify.org/v1/measurements?filter={"feature": "check-point", "thing":"Car 02"}&limit=10&page=1';
const String measurementUrl3 =
    'https:\\students.measurify.org/v1/measurements?filter={"feature": "check-point", "thing":"Car 03"}&limit=10&page=1';
const int numberofCars = 3;

var numberofPosts_car1;
var numberofPosts_car2;
var numberofPosts_car3;

List<Car> cars = [car01, car02, car03];
List<CarSession> session = [];
List<Lap> laps1 = [];
List<Lap> laps2 = [];
List<Lap> laps3 = [];

class LoadingResults extends StatefulWidget {
  const LoadingResults({super.key});

  @override
  State<LoadingResults> createState() => _LoadingResultsState();
}

class _LoadingResultsState extends State<LoadingResults> {
  @override
  Widget build(BuildContext context) {
    session = [];
    laps1 = [];
    laps2 = [];
    laps3 = [];
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

  Future<dynamic> getNumberofPost(BuildContext context) async {
    var url = Uri.parse(measurementUrl1);
    Response response = await get(url, headers: {
      'Accept': 'application/json',
      'Authorization': token,
    });
    var body = json.decode(response.body);
    numberofPosts_car1 = body['totalDocs'] as int;

    url = Uri.parse(measurementUrl2);
    response = await get(url, headers: {
      'Accept': 'application/json',
      'Authorization': token,
    });
    body = json.decode(response.body);
    numberofPosts_car2 = body['totalDocs'] as int;

    url = Uri.parse(measurementUrl3);
    response = await get(url, headers: {
      'Accept': 'application/json',
      'Authorization': token,
    });
    body = json.decode(response.body);
    numberofPosts_car3 = body['totalDocs'] as int;
    run(context);
  }

  void run(BuildContext context) async {
    var data1 = [];
    var data2 = [];
    var data3 = [];

    data1.add(await getSamples(measurementUrl1));
    data2.add(await getSamples(measurementUrl2));
    data3.add(await getSamples(measurementUrl3));

    manageData(data1, context, 1);
    manageData(data2, context, 2);
    manageData(data3, context, 3);

    classify(session, context);
  }

  Future<dynamic> getSamples(String url) async {
    var uri = Uri.parse(url);

    Response response = await get(uri, headers: {
      'Accept': 'application/json',
      'Authorization': token,
    });
    var body = json.decode(response.body);
    body = body["docs"];
    return body;
  }

  void manageData(var data, BuildContext context, int num) async {
    var samples = [];
    var time = [];
    int numberofPost = 0;

    //int numberofPosts = data[0]["totalDocs"];
    if (num == 1) {
      numberofPost = numberofPosts_car1;
    } else if (num == 2) {
      numberofPost = numberofPosts_car2;
    } else {
      numberofPost = numberofPosts_car3;
    }
    print(numberofPost);

    for (int i = (numberofPost - 1); i >= 0; i--) {
      int milli = data[0][i]["samples"][0]["values"][0];
      String start_time = data[0][i]["startDate"];
      start_time = start_time.substring(11, 23);

      samples.add(milli);
      time.add(start_time);
    }

    for (int i = 0; i < samples.length - 1; i++) {
      int diff = samples[i + 1] - samples[i];
      String s_time = time[i];
      String e_time = time[i + 1];
      if (num == 1) {
        laps1.add(Lap(
            execution_num: (i + 1),
            time: diff,
            start_time: convert(s_time),
            end_time: convert(e_time)));
      } else if (num == 2) {
        laps2.add(Lap(
            execution_num: (i + 1),
            time: diff,
            start_time: convert(s_time),
            end_time: convert(e_time)));
      } else {
        laps3.add(Lap(
            execution_num: (i + 1),
            time: diff,
            start_time: convert(s_time),
            end_time: convert(e_time)));
      }
    }

    if (num == 1) {
      laps1.sort(((a, b) => a.time.compareTo(b.time)));
      print("Car1");
      print(laps1[0].time);
    } else if (num == 2) {
      laps2.sort(((a, b) => a.time.compareTo(b.time)));
      print("Car2");
      print(laps2[0].time);
    } else {
      laps3.sort(((a, b) => a.time.compareTo(b.time)));
      print("Car3");
      print(laps3[0].time);
    }

    if (num == 1) {
      CarSession session1 = CarSession(car: car01, laps: laps1);
      session.add(session1);
    } else if (num == 2) {
      CarSession session2 = CarSession(car: car02, laps: laps2);
      session.add(session2);
    } else {
      CarSession session3 = CarSession(car: car03, laps: laps3);
      session.add(session3);
    }
  }

  void classify(List<CarSession> session, BuildContext context) async {
    session.sort(((a, b) => a.laps[0].time.compareTo(b.laps[0].time)));

    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return const ResultsPage();
      },
    ));
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
