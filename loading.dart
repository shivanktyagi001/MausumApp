
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'worker/worker.dart';
class Loading extends StatefulWidget {


  @override
  State<Loading> createState() => _LoadingState();
}


class _LoadingState extends State<Loading> {
  String city = "Hapur";
   late String temp;
   late String hum;
   late String air_speed;
   late String des;
  late String main;
   late String icon;
  void startApp(String city)async
  {
    worker instance = worker(location: city);
    await instance.getData();
    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 1),(){
      Navigator.pushReplacementNamed(context,"/home",arguments: {
        "temp_value" : temp,
        "hum_value": hum,
        "air_speed_value" : air_speed,
        "des_value" : des,
        "main_value": main,
        "icon_value": icon,
        "city_value": city,
    });

    } );
  }
  @override

  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
 if(search!= null && search.containsKey('searchText')){
   city = search?['searchText'];
 }
 startApp(city);
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 120,
            backgroundImage: AssetImage("assets/shivank.webp"),
          ),
          SizedBox(height: 20,),
          Text("Mausum App",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text('Made by Shivank',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
        SizedBox(height: 40,),
        SpinKitWave(
          color: Color(0xFFD37506),
          size: 50.0,
        ),
        ],
      )),
      backgroundColor:Colors.orange[200],
    );
  }
}
