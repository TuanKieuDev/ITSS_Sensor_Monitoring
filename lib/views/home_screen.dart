import 'package:flutter/material.dart';
import 'package:temperature_and_humidity_monitoring/const/custom_styles.dart';
import 'package:temperature_and_humidity_monitoring/widgets/suggestion.dart';

import '../widgets/sensor_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fakeData = [];

    return StreamBuilder(builder: (context, snapshots) {
      // if (snapshots.hasError) {
      //   return const Center(
      //     child: Text('Something went wrong'),
      //   );
      // }

      // if (!snapshots.hasData) {
      //   return const Center(
      //     child: CircularProgressIndicator(),
      //   );
      // }

      return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 16,
          ),
          child: Column(
            children: const [
              Text(
                "Temperature and Humidity Monitoring System",
                style: kHeadline,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              SensorCard(
                value:
                    // data.docs.first.data().humidity,
                    3,
                unit: '%',
                name: 'Humidity',
                assetImage: AssetImage(
                  'assets/images/humidity_icon.png',
                ),
                trendData: [15, 60, 70, 3, 50],
                // rhList!,
                linePoint: Colors.blueAccent,
              ),
              SizedBox(
                height: 20,
              ),
              SensorCard(
                value:
                    // data.docs.first.data().temperature,
                    10,
                unit: '°C',
                name: 'Temperature',
                assetImage: AssetImage(
                  'assets/images/temperature_icon.png',
                ),
                trendData: [1, 20, 8, 3, 6, 4, 8],
                // tempList!,
                linePoint: Colors.redAccent,
              ),
              Suggestion(
                temperature: 8,
                humidity: 3,
              ),
            ],
          ),
        ),
      );
    });
  }
}
