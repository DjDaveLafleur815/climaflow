class WeatherModel {
  final String city;
  final String country;
  final double temperature;
  final double feelsLike;
  final String description;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final String icon;
  final double lat;
  final double lon;

  WeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.icon,
    required this.lat,
    required this.lon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['city'],
      country: json['country'],
      temperature: json['temperature'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      description: json['description'],
      humidity: json['humidity'],
      windSpeed: json['wind_speed'].toDouble(),
      pressure: json['pressure'],
      icon: json['icon'],
      lat: json['coordinates']['lat'].toDouble(),
      lon: json['coordinates']['lon'].toDouble(),
    );
  }
}
