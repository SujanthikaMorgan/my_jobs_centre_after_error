import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/employer/widget/dropdownsearchwidget.dart';
import 'package:my_jobs_center/globalVariables.dart';

class SearchCity extends SearchDelegate {
  late final List<String> cities;

  late String result;
  SearchCity(this.cities);
  String citySel = "";
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            setState() {
              selectedCity = citySel;
            }

            Navigator.pop(context);
          },
        );
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        Navigator.pop(context);
        print(selectedCity);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = cities.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              suggestions.elementAt(index),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              result = suggestions.elementAt(index);
              close(context, result);
              setState() {
                citySel = suggestions.elementAt(index);
              }
            },
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = cities.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              suggestions.elementAt(index),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              query = suggestions.elementAt(index);
              print(query);
              setState() {
                citySel = suggestions.elementAt(index);
              }

              // print(selectedCity);
            },
          );
        },
      );
    });
  }
}
