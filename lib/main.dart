import 'package:bhajanavali/screens/arati.dart';
import 'package:flutter/material.dart';
import 'package:bhajanavali/screens/panchpadi.dart';
import 'package:bhajanavali/screens/pad.dart';
import 'components/button.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      'Arati': (context) => const arati(),
      'Panchpadi': (context) => const panchapadi(),
      'Pad': (context) => const pad(),
    },
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('assets/shreenath.JPEG'),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Button(label: 'Panchpadi'),
                  Button(label: 'Arati',),
                  Button(label: 'Pad'),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
