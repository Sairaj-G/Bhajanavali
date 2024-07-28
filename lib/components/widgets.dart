import 'package:bhajanavali/components/functions.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  String? text ;
  Function? onPressed ;

  Button({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: 0.75*(screenWidth),
      child: ElevatedButton(
        onPressed: () {
          onPressed!();
        },
        child: Text(
            text!,
          style: TextStyle(fontSize: responsiveDimensionResize(20, screenWidth, screenHeight)),
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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CircleAvatar(child: Icon(icon, size: responsiveDimensionResize(20, screenWidth, screenHeight), color: Colors.white), minRadius: responsiveDimensionResize(45, screenWidth, screenHeight), maxRadius: responsiveDimensionResize(45, screenWidth, screenHeight), backgroundColor: Colors.blue);
  }
}

class CustomTextIcon extends StatelessWidget {
  String? text;

  CustomTextIcon({this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return CircleAvatar(child: Text(text!, style: TextStyle(
        fontSize: responsiveDimensionResize(15, screenWidth, screenHeight), color: Colors.white)),
        minRadius: responsiveDimensionResize(45, screenWidth, screenHeight),
        maxRadius: responsiveDimensionResize(45, screenWidth, screenHeight),
        backgroundColor: Colors.blue);
  }
}
