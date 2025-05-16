import 'package:http/http.dart' as http;
import 'dart:convert';

class worker {
  late String location;

  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;
  worker({required this.location});

  Future<void> getData() async {
    try {
      // Build the API URL with the location
      String apiKey = '88b9eda5d0b764565a67bed8bd7e9ef8';
      Uri url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey');

      // Make the GET request
      http.Response response = await http.get(url);

      Map data = jsonDecode(response.body);
      //getting tem,humidity
      Map temp_data = data['main'];
      double getTemp = temp_data['temp'] - 273.15;
      String getHumidity = temp_data['humidity'].toString();
      //getting description

      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDes = weather_main_data["description"];
      String getIcon = weather_main_data['icon'];
      //getting air speed
      Map Wind = data['wind'];
      double getAir_speed = Wind['speed'] * 3.6;
      //assigning values
      temp = getTemp.toStringAsFixed(1);
      humidity = getHumidity;
      air_speed = getAir_speed.toStringAsFixed(1);
      description = getDes;
      main = getMain_des;
      icon = getIcon;
    } catch (e) {
      print("Error Occured!");
      temp = "N/A";
      humidity = "N/A";
      air_speed = "N/A";
      description = "Error fetching data";
      main = "N/A";
      icon = "01d"; // Default weather icon
    }
  }
}
