import 'package:get/get.dart' as t;
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../pages/controller.dart';
class WorldTime{

  String location;
  String time ='';
  String flag;
  String url;
  bool isDayTime =false;

WorldTime({required this.location, required this.flag, required this.url});
  CitiesUrls setTime = Get.put(CitiesUrls());
  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      print(url);
      Map data = jsonDecode(response.body);
      print('$data This is the data in the Api');
      String datetime = data['datetime'];
      print('$datetime This is the DateTime ');
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      print('$offset This is the UTc offset');

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      print('$now This is First');
      now = now.add(Duration(hours: int.parse(offset)));
      print('$now This is Second');


      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
      setTime.time.add(time);
      print('${setTime.time} Time =======');

    }
    catch (e) {
      print('Something went wrong');
      time = 'Something went wr`ong';
    }
  }
}

