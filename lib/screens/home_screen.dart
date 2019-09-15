import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:translator/translator.dart' as translator;
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentItemSelected = 'English';
  var _languages = {
    "English": "en",
    "French": "fr",
    "Spanish": "es",
    "Arabic": "ar",
    "Urdu": "ur",
    "Italian": "it",
    "Russian": "ru",
    "German": "de",
    "Dutch": "nl"
  };
  var text = "Hello world";
  var translatedText = "Hello world";

  var _signImages = {
    "a":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Sign_language_A.svg/323px-Sign_language_A.svg.png",
    "b":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Sign_language_B.svg/198px-Sign_language_B.svg.png",
    "c":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Sign_language_C.svg/416px-Sign_language_C.svg.png",
    "d":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Sign_language_D.svg/242px-Sign_language_D.svg.png",
    "e":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Sign_language_E.svg/286px-Sign_language_E.svg.png",
    "f":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Sign_language_F.svg/244px-Sign_language_F.svg.png",
    "g":
        "https://upload.wikimedia.org/wikipedia/commons/d/d9/Sign_language_G.svg",
    "h":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Sign_language_H.svg/504px-Sign_language_H.svg.png",
    "i":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Sign_language_I.svg/286px-Sign_language_I.svg.png",
    "j":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Sign_language_J.svg/466px-Sign_language_J.svg.png",
    "k":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Sign_language_K.svg/283px-Sign_language_K.svg.png",
    "l":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Sign_language_L.svg/387px-Sign_language_L.svg.png",
    "m":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Sign_language_M.svg/310px-Sign_language_M.svg.png",
    "n":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Sign_language_N.svg/305px-Sign_language_N.svg.png",
    "o":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Sign_language_O.svg/353px-Sign_language_O.svg.png",
    "p":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Sign_language_P.svg/530px-Sign_language_P.svg.png",
    "q":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Sign_language_Q.svg/384px-Sign_language_Q.svg.png",
    "r":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Sign_language_R.svg/233px-Sign_language_R.svg.png",
    "s":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Sign_language_S.svg/336px-Sign_language_S.svg.png",
    "t":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Sign_language_T.svg/341px-Sign_language_T.svg.png",
    "u":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Sign_language_U.svg/246px-Sign_language_U.svg.png",
    "v":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Sign_language_V.svg/249px-Sign_language_V.svg.png",
    "w":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Sign_language_W.svg/280px-Sign_language_W.svg.png",
    "x":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Sign_language_X.svg/362px-Sign_language_X.svg.png",
    "y":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Sign_language_Y.svg/517px-Sign_language_Y.svg.png",
    "z":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Sign_language_Z.svg/368px-Sign_language_Z.svg.png"
  };

  List<dynamic> currImages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currImages = genImages(text);
    CollectionReference reference = Firestore.instance.collection('planets');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) async {
        var googleTranslator = translator.GoogleTranslator();
        var translation = await googleTranslator.translate(text,
            to: _languages[_currentItemSelected]);
        setState(() {
          text = change.document.data['message'];
          currImages = genImages(text);
          translatedText = translation;
        });
      });
    });
  }

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
              images: currImages,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Translation: $translatedText",
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
        ],
      )),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) async {
    var googleTranslator = translator.GoogleTranslator();
    var translation = await googleTranslator.translate(text,
        to: _languages[newValueSelected]);
    setState(() {
      this._currentItemSelected = newValueSelected;
      translatedText = translation;
      currImages = genImages(text);
    });
  }

  List<dynamic> genImages(String text) {
    var result = [];
    for (var c in text.runes) {
      result.add(Image(
        image: NetworkImage(
            (_signImages ?? const {})[String.fromCharCode(c).toLowerCase()] ??
                "http://www.allwhitebackground.com/images/2/2270.jpg"),
        width: 50,
        height: 50,
      ));
    }
    return result;
  }
}
