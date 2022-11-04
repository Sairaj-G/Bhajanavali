
import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';

import '../components/audio_ui.dart';


Duration initial =  Duration(minutes: 0, seconds: 0);
Duration end = Duration(minutes: 28, seconds: 0);

void main() {
  runApp(MaterialApp(
    home : panchapadi(),
  ));
}

AudioPlayer player = AudioPlayer();



bool _playing = false;


class panchapadi extends StatefulWidget {
  const panchapadi({Key? key}) : super(key: key);

  @override
  State <panchapadi> createState() => _MyAppState();
}

class _MyAppState extends State <panchapadi> {
  void initState(){

    super.initState();
    player.setAsset('assets/sound/bhanjan.mp3');
    player.seek(initial);
    player.setClip(start: initial , end : end);
  }

  @override
  void dispose(){
    player.stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context)  {
    return AudioUI(player: player, initial: initial, end: end);
  }
}