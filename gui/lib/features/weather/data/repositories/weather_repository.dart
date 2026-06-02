import 'package:dio/dio.dart';
import '../../domain/models/weather_model.dart';

class WeatherRepository {
  final Dio _dio = Dio();

  // Utilise ton IP locale (celle que tu as mise)
  final String baseUrl = 'http://192.168.1.22:8000/api';

  Future<WeatherModel> getCurrentWeather(String city) async {
    try {
      final response = await _dio.get(
        '$baseUrl/weather/$city',
      ); // ← Correction ici
      print('✅ Réponse API: ${response.statusCode}');
      return WeatherModel.fromJson(response.data);
    } catch (e) {
      print('❌ Erreur API détaillée: $e');
      throw Exception('Erreur lors de la récupération de la météo: $e');
    }
  }
}
