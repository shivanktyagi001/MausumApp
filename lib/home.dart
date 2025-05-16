import 'dart:math';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  void performSearch() {
    String searchText = searchController.text.trim();
    if (searchText.isNotEmpty) {
      Navigator.pushNamed(context, '/loading', arguments: {
        "searchText": searchText,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a city name!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var city_name = ["Mumbai", "Delhi", "Chennai", "Hapur", "Lucknow"];
    final _random = new Random();
    String city;
    if (city_name.isNotEmpty) {
      city = city_name[_random.nextInt(city_name.length)];
    } else {
      city = "Unknown";
    }
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;
    String temp = ((info?['temp_value'] ?? "N/A"));
    if (temp.length >= 4) {
      temp = temp.toString().substring(0, 4);
    }

    String icon = info?['icon_value'] ?? "01d";
    String getcity = info?['city_value'] ?? "Unknown";
    String hum = info?['hum_value'] ?? "N/A";
    String air = info?['air_speed_value'] ?? "N/A";
    String des = info?['des_value'] ?? "N/A";

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: GradientAppBar(
            gradient: LinearGradient(colors: [
              Colors.orange,
              Colors.grey,
            ]),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.orangeAccent,
                  Colors.black26,
                ]),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // for search
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  margin: EdgeInsets.only(left: 10, right: 10, top: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: performSearch,
                          child: Icon(Icons.search),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) {
                              performSearch();
                            },
                            controller: searchController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search $city ..."),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                              "https://openweathermap.org/img/wn/$icon@2x.png"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$des",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "In $getcity",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 22),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(fontSize: 120),
                                ),
                                Text(
                                  "C",
                                  style: TextStyle(fontSize: 50),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 22),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 240,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.day_light_wind),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "$air",
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Km/hr",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24)),
                      margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24)),
                      margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "$hum",
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Percent",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text("Made By Shivank"),
                    Text("Data Provided By OpenWeathermap.org"),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
