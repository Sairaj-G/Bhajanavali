import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  String ?label ;
  String ?text ;

  Button({this.label, this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: 0.75*(screenWidth),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, label!);
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
