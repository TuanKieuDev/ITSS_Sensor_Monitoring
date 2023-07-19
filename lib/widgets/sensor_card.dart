import 'package:flutter/material.dart';

import '../const/constant.dart';

class SensorCard extends StatelessWidget {
  const SensorCard(
      {Key? key,
      required this.value,
      required this.name,
      required this.assetImage,
      required this.unit,
      required this.linePoint})
      : super(key: key);

  final double value;
  final String name;
  final String unit;
  final Color linePoint;
  final AssetImage assetImage;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        shadowColor: Colors.white,
        elevation: 24,
        color: kMainBG,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          width: 60,
                          image: assetImage,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(name,
                            style: kBodyText.copyWith(color: Colors.white)),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 8),
                      child: Text('${value.round()}$unit',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Temperature'),
                    content: const Text(
                        'The amount of water vapor in the air. If there is a lot of water vapor in the air, the humidity will be high. The higher the humidity, the wetter it feels outside.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Understand'),
                      ),
                    ],
                  ),
                ),
                icon: const Icon(Icons.info_outline,
                    color: Color.fromARGB(255, 141, 244, 144)),
              ),
            ),
          ],
        ));
  }
}
