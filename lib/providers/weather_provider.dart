import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../services/api_service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherModel;

  WeatherModel? get weatherModel => _weatherModel;

  Future<void> getWeatherData() async {
    final response = await APIService.getRequest(
      'http://dataservice.accuweather.com/forecasts/v1/hourly/1hour/4-353981_1_AL',
      queryParameters: {
        'apikey': 'SOiJqSQC4U4NpuR1nccGF9FhNhUm8Ik6',
        'language': 'en-us',
        'details': true,
        'metric': true,
      },
    );

    if (response != null) {
      _weatherModel = WeatherModel.fromJson(response[0]);
      notifyListeners();
    }
  }
}
