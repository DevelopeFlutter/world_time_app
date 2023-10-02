import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/data/latest.dart';
import '../services/world_time.dart';
import 'cities_List.dart';
import 'controller.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';
import 'package:new_world_time_app/services/world_time.dart';

class TimeZone extends StatefulWidget {
  const TimeZone({Key
  ? key}) : super(key: key);

  @override
  State<TimeZone> createState() => _TimeZoneState();
}

class _TimeZoneState extends State<TimeZone> {
  var argument = Get.arguments;
  final WorldTime _worldTime =WorldTime(location: '',flag: '',url: '');

  Future setup() async {
    await initializeTimeZones;
    var istanbulTimeZone = tz.getLocation('Europe/Istanbul');
    var now =   tz.TZDateTime.now(istanbulTimeZone);
  }
  dynamic citiesUrl = {
    'London':'Europe/London',
    'Chicago':'America/Chicago',
    'Berlin':'Europe/Berlin',
    'Cairo':'Africa/Cairo',
    'Nairobi':'Africa/Nairobi',
    'New_York':'America/New_York',
    'Seoul':'Asia/Seoul',
    'Jakarta':'Asia/Jakarta'
  };
  bool forTime = true;
  @override
  void initState() {
    timeApiCall();
    super.initState();
  }
  void  timeApiCall() async {
    await  _worldTime.getTime();
  }

  CitiesUrls setUrl = Get.put(CitiesUrls());
  @override
  Widget build(BuildContext context) {
    print('$argument These are the arguments');
    print('${setUrl.time.value} This is the setUrl');
    print('${setUrl.urls.value} This is the setUrl');

    // if(setUrl.time.isNotEmpty){
    //  setState(() {
    //    forTime =true;
    //
    //  });
    // }
    var mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(const CitiesList());
                    },
                    child: const Text('ADD')),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
         if (forTime) Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: setUrl.urls.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height:mediaQuery.size.height/12,
                          child: Padding(
                            padding: const EdgeInsets.only(left:10,right: 10),
                            child:
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                   ()=> Text(
                                      '${setUrl.urls[index]}',
                                      style:  GoogleFonts.montserrat(
                                          fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                    // Obx(()=> Text('${setUrl.time[index]}',style: GoogleFonts.montserrat(fontSize: 22,fontWeight: FontWeight.bold))),
                                ],
                              ),

                          ),
                        ),
                        const Divider(thickness: 2,),
                      ],
                    );
                  }),
            ) else Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Text('add your city whose which you want  see time...',style:  GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}
