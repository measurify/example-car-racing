// ignore_for_file: non_constant_identifier_names

import 'package:flutter/animation.dart';

const String baseUrl = "https:\\students.measurify.org/v1/measurements";

class SpeedSamples {
  double milliseconds;
  double speed;
  Duration time;
  SpeedSamples(
      {required this.milliseconds, required this.speed, required this.time});
}

class AccSamples {
  double milliseconds;
  double acc;
  Duration time;
  AccSamples(
      {required this.milliseconds, required this.acc, required this.time});
}

class TimeSamples {
  int milliseconds;
  String sector;
  TimeSamples({required this.milliseconds, required this.sector});
}

class Lap {
  int execution_num;
  int time;
  Duration start_time;
  Duration end_time;
  Lap(
      {required this.execution_num,
      required this.time,
      required this.start_time,
      required this.end_time});
}

class Car {
  String id;
  Color color;
  Car({required this.id, required this.color});
}

class CarSession {
  Car car;
  List<Lap> laps;
  CarSession({required this.car, required this.laps});
}

