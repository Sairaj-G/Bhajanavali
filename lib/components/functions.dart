import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'audio_ui.dart';
import 'bhajan_time_map.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';



void fastRewind (AudioPlayer player, Duration initial, Duration end) async {
  Duration current = player.position;
  Duration seek = Duration(seconds: 10);
  current - seek < Duration.zero ? await player.seek(Duration.zero) : await player.seek(current - seek);
}

void fastForward (AudioPlayer player, Duration end, Duration initial) async {
  Duration current = player!.position;
  Duration seek = Duration(seconds: 10);
  current + seek  < end - initial  ? await player.seek(current + seek) : await player.seek(end - initial);
}

void stop (AudioPlayer player, Duration initial, Duration end) async {
  await player.stop();
  await player.seek(Duration.zero);
  await player.setClip(start: initial , end: end);
}

void restart (AudioPlayer player, Duration initial, Duration end) async {
  await player.stop();
  await  player.seek(Duration.zero);
  await player.setClip(start: initial , end: end);
  await player.play();
}

Future<void> setup(AudioUI widget) async {
  try {
    final urlSetting = await player.setUrl(widget.audioLink!, initialPosition: widget.initial!);
    final connectionResult = await InternetConnectionCheckerPlus().hasConnection;

    result = connectionResult;
  } catch (e) {
    throw e;
  }
}


Future<void> setupWrapper (AudioUI widget) async {
  await setup(widget);
}

double responsiveDimensionResize(double baseFontSize, double screenWidth, double screenHeight){
  // Base dimensions (e.g., from a standard device like iPhone 11)
  double baseWidth = 384.0;
  double baseHeight = 805.3333333333334;

  // Calculate the scale factor for width and height
  double scaleWidth = screenWidth / baseWidth;
  double scaleHeight = screenHeight / baseHeight;

  // Use the minimum scale factor to ensure the text fits well on both dimensions
  double scaleFactor = (scaleWidth < scaleHeight) ? scaleWidth : scaleHeight;

  // Adjust font size based on scale factor and text scale factor
  double fontSize = baseFontSize * scaleFactor;

  return fontSize;
}
