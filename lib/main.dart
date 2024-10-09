import 'package:bhajanavali/components/constants.dart';
import 'package:bhajanavali/components/functions.dart';
import 'package:bhajanavali/screens/bhajan_list.dart';
import 'package:bhajanavali/screens/bhajan_lyrics_screen.dart';
import 'package:flutter/material.dart';
import 'components/widgets.dart';
import 'package:flutter/services.dart';

BhajanPLayer? bhajanPLayer;
Future<bool>? isDownloadComplete;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bhajanPLayer = BhajanPLayer(bhajanIndex: -1);
  isDownloadComplete = checkAndDownloadBhajan();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) => runApp(MaterialApp(
            initialRoute: '/',
            routes: {
              'BhajanListenScreen': (context) => const BhajanListScreen(),
              'BhajanReadScreen': (context) => const BhajanLyricsScreen()
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
              height: 0.6 * screenHeight,
              width: 0.9 * screenWidth,
              child: Image.asset('assets/shreenath.JPEG'),
            ),
            Center(
                child: Text(" || श्री हालसिध्दनाथ प्रसन्न || ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: responsiveDimensionResize(
                            30, screenWidth, screenHeight)))),
            Container(
                child: StreamBuilder<double>(
                    stream: downloadMultipleFiles(files),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        final progress = snapshot.data!;
                        if (progress == 1) {
                          return Column(
                            children: [
                              Button(text: "श्रवण", onPressed: () {
                                Navigator.pushNamed(context, 'BhajanListenScreen');
                              }),
                              Button(text: "पठण", onPressed: () {
                                Navigator.pushNamed(context, 'BhajanReadScreen');
                              })
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(

                                children: [
                                  LinearProgressIndicator(value: progress, backgroundColor: Colors.white, color: Colors.blue),
                                  Text(
                                      "${(progress*100).toInt()} %",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: responsiveDimensionResize(
                                              15, screenWidth, screenHeight))),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                        "ऑडिओ डाउनलोड होई पर्यंत प्रतीक्षा करावी. डाउनलोड एकदाच होईल.",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: responsiveDimensionResize(
                                                20, screenWidth, screenHeight))),
                                  )
                                ]),
                          );
                        }
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: CircularProgressIndicator(),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
