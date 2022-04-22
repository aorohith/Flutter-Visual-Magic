import 'package:flutter/material.dart';
import 'package:visual_magic/FetchFiles/load_Data.dart';

class sortDropdown extends StatefulWidget {
  const sortDropdown({Key? key}) : super(key: key);

  @override
  State<sortDropdown> createState() => _sortDropdownState();
}

class _sortDropdownState extends State<sortDropdown> {
  String dropdownValue = 'Sort';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      dropdownColor: Colors.black,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        switch(newValue){
          case "A to Z": 
            sortAlphabetical();
            break;
          case "Duration":
            sortByDuration();
            break;
          case "FileSize":
            sortBySize();
            break;
          case "Date":
            sortByDate();
        }
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Shuffled', 'A to Z', 'Duration', 'Date', 'FileSize']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}