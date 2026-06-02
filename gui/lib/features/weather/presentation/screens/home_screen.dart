import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController(text: 'Paris');
  String _currentCity = 'Paris';

  void _searchCity() {
    final city = _searchController.text.trim();
    if (city.isNotEmpty && city != _currentCity) {
      setState(() => _currentCity = city);
      ref.refresh(weatherProvider(city));
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(weatherProvider(_currentCity));

    return Scaffold(
      appBar: AppBar(
        title: const Text('ClimaFlow'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(weatherProvider(_currentCity)),
          ),
        ],
      ),
      body: weatherAsync.when(
        data: (weather) => RefreshIndicator(
          onRefresh: () async => ref.refresh(weatherProvider(_currentCity)),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Recherche
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Rechercher une ville...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _searchCity,
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onSubmitted: (_) => _searchCity(),
                  ),

                  const SizedBox(height: 20),

                  // Carte principale
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: 'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
                            height: 100,
                            width: 100,
                            errorWidget: (context, url, error) => const Icon(Icons.cloud_off, size: 70),
                          ),
                          const SizedBox(height: 12),
                          Text('${weather.city}, ${weather.country}', 
                               style: Theme.of(context).textTheme.headlineSmall),
                          Text('${weather.temperature.round()}°C',
                               style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 64, fontWeight: FontWeight.w300)),
                          Text(weather.description, style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Informations
                  Row(
                    children: [
                      Expanded(child: _buildInfoCard('Ressenti', '${weather.feelsLike.round()}°C', Icons.thermostat_outlined)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInfoCard('Humidité', '${weather.humidity}%', Icons.water_drop_outlined)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildInfoCard('Vent', '${weather.windSpeed} m/s', Icons.air)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInfoCard('Pression', '${weather.pressure} hPa', Icons.speed)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.red),
              const SizedBox(height: 16),
              Text('Erreur: $error'),
              ElevatedButton(
                onPressed: () => ref.refresh(weatherProvider(_currentCity)),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.blue.shade600),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 13)),
            Text(value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
