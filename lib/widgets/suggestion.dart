import 'package:flutter/material.dart';
import 'package:temperature_and_humidity_monitoring/const/constant.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({
    super.key,
    required this.temperature,
    required this.humidity,
  });

  final double temperature;
  final int humidity;

  @override
  Widget build(BuildContext context) {
    String title = '';
    List<String> suggestion = [];
    if (temperature > 30 && humidity > 70) {
      title = 'It is hot and humid.';
      suggestion = [
        'Drink at least 8-10 glasses of water per day',
        'Please turn on the air conditioner.',
        'Wear loose-fitting, breathable clothing.',
      ];
    } else if (temperature > 30 && humidity < 30) {
      title = 'It is hot and dry.';
      suggestion = [
        'Drink at least 8-10 glasses of water a day.',
        'Wear loose-fitting, breathable clothing.',
        'Use a broad-brimmed hat and sunglasses for sun protection.',
      ];
    } else if (temperature < 10 && humidity > 70) {
      title = 'It is cold and humid.';
      suggestion = [
        'Dress in warn layers, including a coat, hat, and gloves.',
        'Use a moisturizer to prevent dry skin.',
        'Wear waterproof or water-resistant outerwear.'
      ];
    } else if (temperature < 10 && humidity < 30) {
      title = 'It is cold and dry.';
      suggestion = [
        'Dress in warn, insulated clothing. Drink plenty of water.',
        'Cover your face with a scarf or mask to protect from cold air.',
        'Drink plenty of water and use a humidifier in your home.'
      ];
    } else {
      title = 'It is normal.';
      suggestion = [
        'Hang out with your friends.',
        'Go to the cinema.',
        'Go to the gym.'
      ];
    }
    return Column(
      children: [
        Text(
          title,
          style: kBodyText2,
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Our suggestions for you:",
              style: TextStyle(
                fontSize: 20,
                color: Colors.amberAccent,
              ),
            ),
          ),
        ),
        for (int i = 0; i < suggestion.length; i++)
          Text(
            '-  ${suggestion[i]}\n',
            style: kBodyText,
          ),
      ],
    );
  }
}
