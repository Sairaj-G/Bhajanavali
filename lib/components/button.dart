import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  String ?label ;
  String ?text ;

  Button({this.label, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, label!);
        },
        child: Text(
            text!,
          style: TextStyle(fontSize: 19),
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
