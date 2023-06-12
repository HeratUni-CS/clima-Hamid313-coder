import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'e72ca729af228beabd5d20e3b7749713';
const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String nameOfCity) async {
    NetworkService networkService =
        NetworkService('$baseUrl?q=$nameOfCity&appid=$apiKey&units=metric');

    var weatherData = await networkService.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location loc = Location();
    await loc.getCurrentLocation();

    NetworkService networkService = NetworkService(
        "$baseUrl?lat=${loc.lat}&lon=${loc.long}&appid=$apiKey&units=metric");

    return await networkService.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
