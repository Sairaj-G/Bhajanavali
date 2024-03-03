import 'package:bhajanavali/components/functions.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  String? text ;
  Function? onPressed ;

  Button({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: 0.75*(screenWidth),
      child: ElevatedButton(
        onPressed: () {
          onPressed!();
        },
        child: Text(
            text!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}



class CustomIcon extends StatelessWidget {
  IconData? icon;
  CustomIcon ({this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(child: Icon(icon, size: 25, color: Colors.white), minRadius: 40.0, backgroundColor: Colors.blue);
  }
}

