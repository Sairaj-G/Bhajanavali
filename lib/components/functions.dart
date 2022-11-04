import 'package:bhajanavali/screens/arati.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

void fastRewind (AudioPlayer player, Duration initial, Duration end){
  Duration current = player.position;
  Duration seek = Duration(seconds: 10);
  current - seek < Duration.zero ? player.seek(Duration.zero) :  player.seek(current - seek);
}

void fastForward (AudioPlayer player, Duration end, Duration initial){
  Duration current = player!.position;
  Duration seek = Duration(seconds: 10);
  current + seek  < end - initial  ? player.seek(current + seek) : player.seek(end - initial);
}

void stop (AudioPlayer player, Duration initial, Duration end){
  player.stop();
  player!.seek(Duration.zero);
  player!.setClip(start: initial , end: end);
}