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
  await player!.seek(Duration.zero);
  await player!.setClip(start: initial , end: end);
}

void restart (AudioPlayer player, Duration initial, Duration end) async {
  await player!.stop();
  await  player!.seek(Duration.zero);
  await player!.setClip(start: initial , end: end);
  await player.play();
}

Future<void> setup(AudioUI widget) async {
  try {
    // Execute tasks in parallel
    final urlSetting = player.setUrl(widget.audioLink!, initialPosition: widget.initial!);
    final connectionResult = await InternetConnectionCheckerPlus().hasConnection;

    // Wait for all tasks to complete
    await Future.wait([urlSetting]);

    // Check internet connection in parallel


    // Update result after all tasks completed
    result = connectionResult;
  } catch (e) {
    throw e;
  }
}
