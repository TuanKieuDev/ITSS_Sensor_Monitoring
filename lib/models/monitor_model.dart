class MonitorModel {
  String name;
  double humidity;
  double temperature;
  double feelLike;
  String advice;

  MonitorModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        humidity = json['humidity'],
        temperature = json['temperature'],
        feelLike = json['feels_like'],
        advice = json['advice'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'humidity': humidity,
        'temperature': temperature,
        'feels_like': feelLike,
        'advice': advice,
      };
}
