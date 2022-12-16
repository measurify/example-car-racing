import 'package:flutter/material.dart';
import 'package:car_manager_app/app_button.dart';
import 'package:car_manager_app/loading_charts.dart';

late int target;

class CarsNew extends StatelessWidget {
  const CarsNew({super.key});

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
              operation: '              CAR 01',
              operationColor: Colors.red,
              description: '',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      target = 1;
                      return const LoadinPage();
                    },
                  ),
                );
              },
            ),
            AppButton(
              operation: '              CAR 02',
              operationColor: Colors.blue,
              description: '',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      target = 2;
                      return const LoadinPage();
                    },
                  ),
                );
              },
            ),
            AppButton(
              operation: '              CAR 03',
              operationColor: Colors.green,
              description: '',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      target = 3;
                      return const LoadinPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
