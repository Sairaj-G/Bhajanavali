import 'package:bhajanavali/screens/bhajan_list.dart';
import 'package:flutter/material.dart';
import 'components/button.dart';
import 'components/bhajan_time_map.dart';
import 'package:change_app_package_name/change_app_package_name.dart';

void main() {
  runApp(MaterialApp(

    initialRoute: '/',
    routes: {
      'BhajanListScreen' : (context) => const BhajanListScreen(),
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
                  Button(text : "नित्य भजन सेवा", label: 'BhajanListScreen'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
