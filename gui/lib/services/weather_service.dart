import 'package:dio/dio.dart';
import '../models/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.1.22:8000/api';

  Future<WeatherModel> getWeather(String city) async {
    try {
      final response = await _dio.get('$baseUrl/weather/$city');
      return WeatherModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Erreur lors de la récupération de la météo');
    }
  }
}
