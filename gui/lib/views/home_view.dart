import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/weather_model.dart';
import '../controllers/weather_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final WeatherController _controller = WeatherController();
  WeatherModel? _weather;
  bool _isLoading = false;
  String _error = '';

  final TextEditingController _cityController = TextEditingController(
    text: 'Paris',
  );

  Future<void> _loadWeather(String city) async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final data = await _controller.getWeather(city);
      setState(() => _weather = data);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadWeather('Paris');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ClimaFlow'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: 'Rechercher une ville...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _loadWeather(_cityController.text),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: _loadWeather,
              ),
              const SizedBox(height: 16),

              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _error.isNotEmpty
                    ? Center(
                        child: Text(
                          'Erreur : $_error',
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : _weather == null
                    ? const Center(child: Text('Aucune donnée'))
                    : RefreshIndicator(
                        onRefresh: () => _loadWeather(_weather!.city),
                        child: ListView(
                          children: [
                            Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          'https://openweathermap.org/img/wn/${_weather!.icon}@4x.png',
                                      height: 90,
                                      width: 90,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '${_weather!.city}, ${_weather!.country}',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${_weather!.temperature.round()}°C',
                                      style: const TextStyle(
                                        fontSize: 58,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      _weather!.description,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Informations en ligne simple pour éviter tout overflow
                            _buildInfoRow(
                              'Ressenti',
                              '${_weather!.feelsLike.round()}°C',
                              Icons.thermostat_outlined,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'Humidité',
                              '${_weather!.humidity}%',
                              Icons.water_drop_outlined,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'Vent',
                              '${_weather!.windSpeed} m/s',
                              Icons.air,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'Pression',
                              '${_weather!.pressure} hPa',
                              Icons.speed,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 26, color: Colors.blue.shade600),
            const SizedBox(width: 16),
            Text(label, style: const TextStyle(fontSize: 15)),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
