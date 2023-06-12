import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.weatherData});

  final dynamic weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? message;
  String? weathIcon;
  String? nameOfCity;
  int? heat;
  WeatherModel weath = WeatherModel();

  @override
  void initState() {
    super.initState();

    setUpdate(widget.weatherData);
  }

  void setUpdate(dynamic weatherData) => setState(() {
        if (weatherData == null) {
          weathIcon = 'Error';
          heat = 0;
          message = 'Unable to get weather data';
          nameOfCity = '';
          return;
        }
        double temp = weatherData['main']['temp'];
        heat = temp.toInt();
        var condition = weatherData['weather'][0]['id'];
        weathIcon = weath.getWeatherIcon(condition);
        message = weath.getMessage(heat!);
        nameOfCity = weatherData['name'];
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage('images/location_background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.dstATop))),
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () async =>
                                setUpdate(await weath.getLocationWeather()),
                            icon: const Icon(Icons.near_me, size: 50.0)),
                        IconButton(
                            onPressed: () async {
                              final typedName = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CityScreen(),
                                  ));
                              if (typedName != null) {
                                final weatherData =
                                    await weath.getCityWeather(typedName);
                                setUpdate(weatherData);
                              }
                            },
                            icon: const Icon(
                              Icons.location_city,
                              size: 50.0,
                            ))
                      ]),
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(children: [
                        Text('$heat°', style: kTempTextStyle),
                        Text(weathIcon ?? "", style: kConditionTextStyle)
                      ])),
                  Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        '$message in $nameOfCity',
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle,
                      ))
                ]))));
  }
}
