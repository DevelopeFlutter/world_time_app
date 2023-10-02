import 'package:flutter/material.dart';
import 'package:new_world_time_app/pages/HomeScreen.dart';
import 'package:new_world_time_app/pages/choose_location.dart';
import 'package:new_world_time_app/pages/home.dart';
import 'package:new_world_time_app/pages/loading.dart';
import 'package:get/get.dart';
void main() => runApp(
    const GetMaterialApp(
            debugShowCheckedModeBanner: false,
        home: TimeZone(),
// initialRoute: '/',
// routes:{
//     '/': (context) => Loading(),
//     '/home': (context) => Home(),
//     '/location': (context) => ChoosheLocation(),
//   },
// )
));