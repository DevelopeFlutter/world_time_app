import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }
  static  dynamic data = {};
  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      data = data;
      print('$data This is the data in the if Part ');
    } else {
      data = ModalRoute.of(context)?.settings.arguments;
      print('$data This is the data in the else Part ');
    }
    print('$data Data===========>');
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.black;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage('assets/$bgImage'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    print('$result this is the Result');

                    data['time'] = result['time'];
                    data['location'] = result['location'];
                    data['isDayTime'] = result['isDayTime'];
                    data['flag'] = result['flag'];
                    print('$data On press');
                  });
                  },
                icon: const Icon(Icons.pin_drop, color: Colors.white,),
                //   label: Text(
                //   "Edit Location",
                //   style: TextStyle(color: Colors.white),
                // )
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  data['location'],
                  style: const TextStyle(
                      color: Colors.white, fontSize: 28, letterSpacing: 2),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              data['time'],
              style: const TextStyle(
                  color: Colors.white, fontSize: 37, letterSpacing: 2),
            )
          ],
        ),
      )),
    );
  }
}
