import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';

class WeatherModel {
  Future<dynamic> getCityData(var cityName) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=d50f9594bd90586d244cc064a5ce9eeb&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var decodeData = await networkHelper.getData();
    return decodeData;
  }

  Future<dynamic> getLocationData() async {
    Location present = Location();
    await present.getLocation();
    double longitude = present.longitude;
    double latitude = present.latitude;
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=d50f9594bd90586d244cc064a5ce9eeb&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var decodeData = await networkHelper.getData();
    return decodeData;
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
