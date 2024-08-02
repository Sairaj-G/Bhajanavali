import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'audio_ui.dart';
import 'bhajan_time_map.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';


class BhajanPLayer  {

   int? bhajanIndex;
   AudioPlayer? player;

   BhajanPLayer({required int bhajanIndex}){
     this.bhajanIndex = bhajanIndex;
     this.player = AudioPlayer();
   }

   Future <void> loadCurrentBhajan () async {
     bool loaded = false;
     while (!loaded) {
       try {
         var urlSettings = await player!.setUrl(audioURL[bhajanIndex!]);
         loaded = true;
       } catch (e) {};
         await Future.delayed(Duration(seconds: 2));
       }
     }
     void loadCurrentBhajanHelper() async {
        await loadCurrentBhajan();
     }

   void changeBhajan (int changedIndex) async {
     await player!.stop();
     bhajanIndex = changedIndex;
     loadCurrentBhajan();
   }

   void playNextBhajan(BuildContext context) {
     if (bhajanIndex == bhajanTitles.length - 1) {
       return;
     }else{
       Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => AudioUI(bhajanIndex! + 1)));
     }
   }

   void playPrevBhajan(BuildContext context) {
     if (bhajanIndex == 0) {
      return;
     }
     else {
       Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => AudioUI(bhajanIndex! - 1)));
     }
   }

   void fastRewind () async {
    Duration current = player!.position;
    Duration seek = Duration(seconds: 5);
    current - seek < Duration.zero ? await player!.seek(Duration.zero) : await player!.seek(current - seek);
   }

   void fastForward () async {
    Duration end = bhajanEndDurations[bhajanIndex!];
    Duration initial = Duration.zero;
    Duration current = player!.position;
    Duration seek = Duration(seconds: 5);
    current + seek  < end - initial  ? await player!.seek(current + seek) : await player!.seek(end - initial);
   }

   void stopAndReset () async {
    Duration end = bhajanEndDurations[bhajanIndex!];
    Duration initial = Duration.zero;
    await player!.stop();
    await player!.seek(Duration.zero);
    await player!.setClip(start: initial , end: end);
   }

   void restart () async {
    Duration end = bhajanEndDurations[bhajanIndex!];
    Duration initial = Duration.zero;
    await player!.stop();
    await player!.seek(Duration.zero);
    await player!.setClip(start: initial , end: end);
    await player!.play();
   }

   void play () {
      player!.play();
   }

   void pause () {
      player!.pause();
   }

   Future <void> seek (Duration duration) async {
     await player!.seek(duration);
   }

   Future<void> updateInternetConnectionStatus () async {
     final connectionResult = await InternetConnectionCheckerPlus().hasConnection;
     result = connectionResult;
   }

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

class InternetConnectivityService {

  final Connectivity _connectivity = Connectivity();
  StreamController<bool> _controller = StreamController.broadcast();

  InternetConnectivityService() {
    _checkInternetConnectivity();
  }

  Stream<bool> get connectivityStream => _controller.stream;

  void _checkInternetConnectivity() {
    Timer.periodic(Duration(seconds: 3), (timer) async {
      var connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        bool isConnected = await _hasInternetConnection();
        _controller.add(isConnected);
      } else {
        _controller.add(false);
      }
    });
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final response = await http.head(Uri.parse('https://www.google.com'))
          .timeout(Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    _controller.close();
  }
}
