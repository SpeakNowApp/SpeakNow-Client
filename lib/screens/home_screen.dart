import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentItemSelected = 'English';
  var _languages = {"English": "en", "French": "fr", "Spanish": "es"};
  var text = "My name is Hussein";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SpeakNow App"),
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50.0),
          SizedBox(
            height: 250.0,
            child: Carousel(
              images: [
                NetworkImage(
                    'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                NetworkImage(
                    'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                NetworkImage(
                    'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Translation: INSERT HERE",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Center(
            child: DropdownButton<String>(
              items: _languages.keys.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                // Your code to execute, when a menu item is selected from drop down
                _onDropDownItemSelected(newValueSelected);
              },
              value: _currentItemSelected,
            ),
          ),
          Text(text)
        ],
      )),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) async {
    var request = await http.get(
        "https://translate.google.com/?client=safari&rls=en&oe=UTF-8&um=1&ie=UTF-8&hl=en&client=tw-ob#en/${_languages[_currentItemSelected]}/${text}");
    print(request.body);

    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}
