import 'package:flutter/material.dart';
import 'package:temperature_and_humidity_monitoring/const/custom_styles.dart';
import 'package:temperature_and_humidity_monitoring/widgets/suggestion.dart';

import '../widgets/sensor_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fakeData = [
    {
      "tempList": <double>[1, 20, 8, 3, 6],
      "rhList": <double>[15, 60, 70, 3, 50],
    },
    {
      "tempList": <double>[6, 3, 7, 23, 5],
      "rhList": <double>[3, 9, 3, 5, 1],
    },
  ];
  int _value = 1;

  @override
  Widget build(BuildContext context) {
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

      final rhList = fakeData[_value - 1]['rhList'] as List<double>;
      final tempList = fakeData[_value - 1]['tempList'] as List<double>;

      return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 16,
          ),
          child: Column(
            children: [
              const Text(
                "Temperature and Humidity Monitoring System",
                style: kHeadline,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              _HumidityAndTemperature(rhList: rhList, tempList: tempList),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 1; i <= fakeData.length; i++)
                      ChoiceChip(
                        label: Text('Chip $i'),
                        labelStyle: TextStyle(
                            color: _value == i ? Colors.white : Colors.black),
                        selected: _value == i,
                        selectedColor: Colors.blueAccent,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = i;
                          });
                        },
                      ),
                  ],
                ),
              ),
              const Suggestion(
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

class _HumidityAndTemperature extends StatelessWidget {
  const _HumidityAndTemperature({
    required this.rhList,
    required this.tempList,
  });

  final List<double> rhList;
  final List<double> tempList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SensorCard(
          value:
              // data.docs.first.data().humidity,
              rhList.last,
          unit: '%',
          name: 'Humidity',
          assetImage: const AssetImage(
            'assets/images/humidity_icon.png',
          ),
          trendData: rhList,
          linePoint: Colors.blueAccent,
        ),
        const SizedBox(
          height: 20,
        ),
        SensorCard(
          value:
              // data.docs.first.data().temperature,
              tempList.last,
          // 10,
          unit: '°C',
          name: 'Temperature',
          assetImage: const AssetImage(
            'assets/images/temperature_icon.png',
          ),
          trendData: tempList,
          linePoint: Colors.redAccent,
        ),
      ],
    );
  }
}
