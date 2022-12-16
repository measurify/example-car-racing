// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:car_manager_app/credits.dart';
import 'package:car_manager_app/loading_results.dart';
import 'package:flutter/material.dart';
import 'app_button.dart';
import 'dart:convert';
import "package:http/http.dart";

import 'main.dart';

const String baseUrl = 'https:\\students.measurify.org/v1/login';

class HomePageNew extends StatefulWidget {
  const HomePageNew({super.key});

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  @override
  void initState() {
    login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const FlutterLogo(size: 72),
              AppButton(
                operation: '            RESULTS',
                operationColor: Colors.lightGreen,
                description: '',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LoadingResults();
                      },
                    ),
                  );
                },
              ),
              AppButton(
                operation: "              CREDIT",
                operationColor: Colors.lightGreen,
                description: "",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const CreditsPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> login() async {
    var url = Uri.parse(baseUrl);
    print(url);
    var _body = {
      "username": "car-manager-user-username",
      "password": "car-manager-user-password",
      "tenant": "car-manager-tenant"
    };
    Response response =
        await post(url, body: _body, headers: {'Accept': 'application/json'});
    var body = json.decode(response.body);
    token = body['token'];
    return;
  }
}
