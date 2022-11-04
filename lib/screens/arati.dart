import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../components/audio_ui.dart';

Duration initial =  Duration(minutes: 28, seconds: 00);
Duration end = Duration(minutes: 44, seconds: 1);

void main() {
  runApp(MaterialApp(
    home : arati(),
  ));
}

AudioPlayer player = AudioPlayer();

class arati extends StatefulWidget {
  const arati ({Key? key}) : super(key: key);


  State <arati> createState() => _MyAppState();
}

class _MyAppState extends State<arati> {
  bool _playing = false;

  @override
  void initState(){
    super.initState();
    player.setAsset('assets/sound/bhanjan.mp3');
    player.seek(Duration(minutes: 28, seconds: 0));
    player.setClip(start: Duration(minutes: 28, seconds: 00), end : Duration(minutes: 44, seconds: 1));
  }

  @override
  void dispose(){
    player.stop();
    super.dispose();
  }

  @override
  Widget build (BuildContext context) {
    return AudioUI(player: player, initial: initial, end: end);
  }

}

