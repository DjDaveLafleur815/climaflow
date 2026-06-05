import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherController {
  final WeatherService _service = WeatherService();

  Future<WeatherModel> getWeather(String city) async {
    return await _service.getWeather(city);
  }
}
