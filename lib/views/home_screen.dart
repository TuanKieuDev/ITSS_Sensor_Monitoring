import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:temperature_and_humidity_monitoring/const/custom_styles.dart';
import 'package:temperature_and_humidity_monitoring/models/monitor_model.dart';

import '../widgets/sensor_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StreamController<MonitorModel> _streamController = StreamController();
  int _value = 1;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      getApi();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  Future<void> getApi() async {
    var url = Uri.parse('http://192.168.4.2');
    // var url = Uri.parse("https://libido.serveo.net");
    final response = await http.get(url);
    final data = json.decode(response.body)[_value - 1];

    MonitorModel monitorModel = MonitorModel.fromJson(data);

    _streamController.sink.add(monitorModel);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MonitorModel>(
        stream: _streamController.stream,
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (!snapshots.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshots.requireData;

          final advice1 = data.advice.split(":");
          final advice2 = advice1[1].split(".");

          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 60,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  const Text(
                    "T&H Monitoring System",
                    style: kHeadline,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 1; i <= 2; i++)
                          ChoiceChip(
                            label: Text('Chip $i'),
                            labelStyle: TextStyle(
                                color:
                                    _value == i ? Colors.white : Colors.black),
                            selected: _value == i,
                            selectedColor: Colors.blueAccent,
                            onSelected: (bool selected) {
                              getApi();
                              setState(() {
                                _value = i;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                  _HumidityAndTemperature(
                    humidity: data.humidity,
                    temperature: data.temperature,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Feeling like: ',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(221, 88, 214, 1)),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${data.feelLike.round()}°C',
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 231, 155, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Last updated: ${DateFormat('jms').format(DateTime.now())}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // const Suggestion(
                  //   temperature: 8,
                  //   humidity: 3,
                  // ),
                  Text(
                    advice1[0],
                    style: const TextStyle(
                      color: Color.fromRGBO(147, 54, 180, 1),
                      fontSize: 25,
                    ),
                  ),
                  for (int i = 0; i < advice2.length; i++)
                    if (advice2[i].isNotEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "- ${advice2[i]}\n",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
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
    required this.humidity,
    required this.temperature,
  });

  final double humidity;
  final double temperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SensorCard(
          value: humidity,
          unit: '%',
          name: 'Humidity',
          assetImage: const AssetImage(
            'assets/images/humidity_icon.png',
          ),
          linePoint: Colors.blueAccent,
        ),
        const SizedBox(
          height: 20,
        ),
        SensorCard(
          value: temperature,
          // 10,
          unit: '°C',
          name: 'Temperature',
          assetImage: const AssetImage(
            'assets/images/temperature_icon.png',
          ),
          linePoint: Colors.redAccent,
        ),
      ],
    );
  }
}
