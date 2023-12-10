import 'package:bhajanavali/screens/bhajan_list.dart';
import 'package:bhajanavali/screens/bhajan_lyrics_screen.dart';
import 'package:flutter/material.dart';
import 'components/button.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]).then((value) => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      'BhajanListenScreen' : (context) => const BhajanListScreen(),
      'BhajanReadScreen' : (context) => const BhajanLyricsScreen()
    },
    home: MyApp(),
  )));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 0.6*screenHeight,
              width: 0.9*screenWidth,
              child: Image.asset('assets/shreenath.JPEG'),
            ),
            Container(
              child: Column(
                children: [
                  Button(text : "श्रवण", label: 'BhajanListenScreen'),
                  Button(text : "पठण", label: 'BhajanReadScreen')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
