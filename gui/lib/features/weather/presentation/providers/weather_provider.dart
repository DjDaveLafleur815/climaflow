import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/weather_repository.dart';
import '../../domain/models/weather_model.dart';

/// Repository Provider
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});

/// Weather Provider - Charge la météo d'une ville
final weatherProvider = FutureProvider.autoDispose.family<WeatherModel, String>(
  (ref, city) async {
    final repository = ref.watch(weatherRepositoryProvider);
    return await repository.getCurrentWeather(city);
  },
);
