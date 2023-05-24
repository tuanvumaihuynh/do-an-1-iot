class WeatherModel {
  bool isDaylight;
  bool isRaining;
  String weatherStatus;
  double temperature;
  int humidity;

  WeatherModel(
      {required this.humidity,
      required this.temperature,
      required this.weatherStatus,
      required this.isDaylight,
      required this.isRaining});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      humidity: json['RelativeHumidity'],
      temperature: json['Temperature']['Value'],
      weatherStatus: json['PrecipitationType'],
      isDaylight: json['IsDaylight'],
      isRaining: json['HasPrecipitation']);

  Map<String, dynamic> toJson() => {
        'humidity': humidity,
        'temperature': temperature,
        'weatherStatus': weatherStatus,
        'isDayLight': isDaylight,
        'isRaining': isRaining
      };
}
