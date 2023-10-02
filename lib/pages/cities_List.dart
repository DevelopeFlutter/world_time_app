import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../services/world_time.dart';
import 'controller.dart';

class CitiesList extends StatefulWidget {
  const CitiesList({Key? key}) : super(key: key);

  @override
  State<CitiesList> createState() => _CitiesListState();
}

class _CitiesListState extends State<CitiesList> {
  TextEditingController urlController = TextEditingController();
  bool ForIcon = false;
  CitiesUrls setUrl = Get.put(CitiesUrls());
  List<dynamic> cities = [
    'Berlin',
    'Athens',
    'Cairo',
    'Nairobi',
    'Chicago',
    'New York',
    'Seoul',
    'Jakarta'
  ];

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Cities For Finding Time'),
      ),
      body: TypeAheadFormField(
          onSuggestionSelected: (dynamic val) async{

            dynamic city = citiesUrl[val];
            print('$city Value in the Variable City');
            WorldTime instance =
            WorldTime(location: 'Berlin', flag: '', url:'Europe/Berlin');
            print('This is run');
            await instance.getTime();
            urlController.text = val;
            Get.back();
          },
          itemBuilder: (context, dynamic item) {
            return ListTile(title: Text(item));
          },
          suggestionsCallback: (pattern) => cities.where((element) =>
              element.toLowerCase().contains(pattern.toLowerCase())),
          hideSuggestionsOnKeyboardHide: true,
          noItemsFoundBuilder: (context) => const Padding(
                padding: EdgeInsets.only(
                  left: 8,
                ),
                child: SizedBox(
                    height: 30,
                    child: Text(
                      "No item Found",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    )),
              ),
          textFieldConfiguration: TextFieldConfiguration(
            controller: urlController,
            autofocus: true,
            onChanged: (dynamic value) {
              if (value.isEmpty) {
                setState(() {
                  ForIcon = false;
                });
              } else {
                setState(() {
                  ForIcon = true;
                });
              }
              // SkillController.text = value ;
              // SkillController.selection = TextSelection.fromPosition(
              //     TextPosition(offset:SkillController.text.length));
              setState(() {
                // skillController.skills.value=value ;
              });
            },
            decoration: InputDecoration(
                suffixIcon: ForIcon
                    ? IconButton(
                        onPressed: () {
                          urlController.clear();
                          setState(() {
                            ForIcon = false;
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                        ))
                    : null,
                hintText: "Search...",
                contentPadding: const EdgeInsets.only(left: 15, top: 15)
                //
                ),
          )),
    );
  }
}
