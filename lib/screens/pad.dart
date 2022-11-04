import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../components/audio_ui.dart';

Duration initial =  Duration(minutes: 44, seconds: 1);
Duration end = Duration(minutes: 59, seconds: 55);
AudioPlayer player = AudioPlayer();

void main() {
  runApp(MaterialApp(
    home: pad (),
  ));
}

class pad extends StatefulWidget {
  const pad ({Key? key}) : super(key: key);
  @override
  State <pad> createState() => _MyAppState();
}

class _MyAppState extends State<pad> {

  @override
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
  Widget build(BuildContext context) {
    return AudioUI(player: player, initial: initial, end: end);
  }
}