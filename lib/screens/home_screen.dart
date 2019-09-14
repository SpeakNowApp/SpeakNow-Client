import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var _languages = ['English', 'French', 'Spanish'];
  var _currentItemSelected = 'English';

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
                    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                    NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Translation: HI",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              DropdownButton<String>(

                items: _languages.map((String dropDownStringItem) {
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
            ],
          )
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

}
