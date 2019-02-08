import 'package:flutter/material.dart';
//import 'package:firebase_admob/firebase_admob.dart';
import "ads.dart";
import 'words.dart';

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const String testDevice = 'E51F2CF7DFF32DF5DE76FAB664A8E9E5';

// Define a Custom Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  String data = "";

  void _submit() {
    // Built in Flutter Method.
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      data = textController.text;
    });
  }

  @override
  void dispose(){
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: textController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter lowercase text intend to unscramble';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: _submit,
              child: Text('Unscramble'),
            ),
          ),
          new Expanded(
            child: _buildSuggestions(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/
          List<String> _suggestions =  getWords(data);
          final index = i ~/ 2; /*3*/
          if (index < _suggestions.length)
            return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(String word) {
    return ListTile(
      title: Text(
        word,
        style: _biggerFont,
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _coins = 0;
  //static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //  keywords: ['Games', 'Puzzles'],
  //);
/*
  BannerAd bannerAd;

  BannerAd buildBanner() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          print(event);
        });
  }
*/
  @override
  void initState() {
    super.initState();
    //FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    //bannerAd = buildBanner()..load();

     Ads.init('ca-app-pub-7821168080202935~6933403773', testing: true);
     List<String> testDevices = [];
     testDevices.add('E51F2CF7DFF32DF5DE76FAB664A8E9E5');
     Ads.testDevices = testDevices;
    //Ads.video.rewardedListener = (String rewardType, int rewardAmount){
    //   setState(() {
    //     _coins += rewardAmount;
    //   });
    // };

    Ads.showBannerAd(this);
  }

  @override
  void dispose() {
    Ads.dispose();
    //bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //bannerAd..show();
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Unscramble'),
        ),
        body:MyCustomForm(),
      ),
    );
  }
}

void main() {
  runApp(new MyApp());
}