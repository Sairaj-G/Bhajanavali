import 'dart:async';
import 'dart:core';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'audio_ui.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class BhajanPLayer {
  int? bhajanIndex;
  AudioPlayer? player;

  BhajanPLayer({required int bhajanIndex}) {
    this.bhajanIndex = bhajanIndex;
    this.player = AudioPlayer();
  }

  Future<void> loadCurrentBhajan() async {
    bool loaded = false;
    while (!loaded) {
      try {
        await player!.setFilePath(audioFilePath[bhajanIndex!]);
        await player!.setClip(
            start: bhajanStartDurations[bhajanIndex!],
            end: bhajanEndDurations[bhajanIndex!]);
        loaded = true;
      } catch (e) {}
      ;
      await Future.delayed(Duration(seconds: 2));
    }
  }

  void loadCurrentBhajanHelper() async {
    try {
      await loadCurrentBhajan();
    } catch (e) {
      print('Error in loadCurrentBhajanHelper: $e');
    }
  }

  void changeBhajan(int changedIndex) async {
    try {
      await player!.stop();
      bhajanIndex = changedIndex;
      await loadCurrentBhajan();
    } catch (e) {
      print('Error in changeBhajan: $e');
    }
  }

  void playNextBhajan(BuildContext context) {
    try {
      if (bhajanIndex == bhajanTitles.length - 1) {
        return;
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AudioUI(bhajanIndex! + 1)),
        );
      }
    } catch (e) {
      print('Error in playNextBhajan: $e');
    }
  }

  void playPrevBhajan(BuildContext context) {
    try {
      if (bhajanIndex == 0) {
        return;
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AudioUI(bhajanIndex! - 1)),
        );
      }
    } catch (e) {
      print('Error in playPrevBhajan: $e');
    }
  }

  void fastRewind() async {
    try {
      Duration current = player!.position;
      Duration seek = Duration(seconds: 5);
      if (current - seek < Duration.zero) {
        await player!.seek(Duration.zero);
      } else {
        await player!.seek(current - seek);
      }
    } catch (e) {
      print('Error in fastRewind: $e');
    }
  }

  void fastForward() async {
    try {
      Duration end = bhajanEndDurations[bhajanIndex!];
      Duration initial = Duration.zero;
      Duration current = player!.position;
      Duration seek = Duration(seconds: 5);
      if (current + seek < end - initial) {
        await player!.seek(current + seek);
      } else {
        await player!.seek(end - initial);
      }
    } catch (e) {
      print('Error in fastForward: $e');
    }
  }

  void stopAndReset() async {
    try {
      Duration end = bhajanEndDurations[bhajanIndex!];
      Duration initial = bhajanStartDurations[bhajanIndex!];
      await player!.stop();
      await player!.seek(bhajanStartDurations[bhajanIndex!]);
      await player!.setClip(start: initial, end: end);
    } catch (e) {
      print('Error in stopAndReset: $e');
    }
  }

  void restart() async {
    try {
      Duration end = bhajanEndDurations[bhajanIndex!];
      Duration initial = bhajanStartDurations[bhajanIndex!];
      await player!.stop();
      await player!.seek(bhajanStartDurations[bhajanIndex!]);
      await player!.setClip(start: initial, end: end);
      await player!.play();
    } catch (e) {
      print('Error in restart: $e');
    }
  }

  void triggerPlay () {
    try{
      play();
    }catch (e) {
      print("Error in triggerPlay : $e");
    }
  }
  void play() async {
    try {
      await player!.play();
    } catch (e) {
      print('Error in play: $e');
    }
  }

  void pause() async {
    try {
      await player!.pause();
    } catch (e) {
      print('Error in pause: $e');
    }
  }

  Future<void> seek(Duration duration) async {
    try {
      await player!.seek(duration);
    } catch (e) {
      print('Error in seek: $e');
    }
  }

}

double responsiveDimensionResize(
    double baseFontSize, double screenWidth, double screenHeight) {
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

Future<File> getFileFromAppStorage(String fileName, String url) async {
  // Get the app-specific directory
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String filePath = '${appDocDir.path}/$fileName';

  File file = File(filePath);

  // Check if the file exists
  if (await file.exists()) {
    print("File exists in app storage: $filePath");
    return file;
  } else {
    // If the file does not exist, download it from the provided URL
    print("Downloading file from URL: $url");

    // Download the file
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Write the file to the app-specific storage
      file = await file.writeAsBytes(response.bodyBytes);
      print("File downloaded and saved: $filePath");
      return file;
    } else {
      throw Exception("Failed to download file: ${response.statusCode}");
    }
  }
}

// Function to get the size of a single file using a HEAD request
Future<int> getFileSize(String url) async {
  final response = await http.head(Uri.parse(url));
  if (response.statusCode == 200) {
    final contentLength = response.headers['content-length'];
    if (contentLength != null) {
      return int.parse(contentLength);
    } else {
      throw Exception('Content-Length header is missing');
    }
  } else {
    throw Exception('Failed to get file size: ${response.statusCode}');
  }
}

// Function to estimate the total size of multiple files
Future<List<int>> estimateTotalSizes(List<Map<String, dynamic>> files) async {
  List<int> fileSizes = [];

  for (var file in files) {
    try {
      // Fetch the size of each file and add it to the list
      int fileSize = await getFileSize(file['url']!);
      fileSizes.add(fileSize);
      print('File: ${file['name']}, Size: $fileSize bytes');
    } catch (e) {
      print('Failed to get size for ${file['name']}: $e');
      fileSizes.add(0); // Add 0 if file size cannot be determined
    }
  }

  return fileSizes; // Return the list of file sizes
}

// Function to download a file and return a stream of progress
Stream<int> downloadFile(String url, String fileName, int totalSize) async* {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$fileName';
  final file = File(filePath);

  if (await file.exists() && await file.length() == totalSize) {
    yield totalSize; // If the file exists, emit its total size as downloaded
    return;
  }

  try {
    final response =
        await http.Client().send(http.Request('GET', Uri.parse(url)));
    if (response.statusCode == 200) {
      final contentLength = response.contentLength ?? 0;
      int downloadedBytes = 0;
      final fileStream = file.openWrite();

      await for (final chunk in response.stream) {
        downloadedBytes += chunk.length;
        fileStream.add(chunk);
        yield downloadedBytes; // Emit the number of bytes downloaded so far
      }

      await fileStream.close();
      yield contentLength; // Emit full size when download is complete
    } else {
      throw Exception('Failed to download file');
    }
  } catch (e) {
    throw e;
  }
}

// Function to combine the progress of multiple downloads into a single stream
Stream<double> downloadMultipleFiles(List<Map<String, dynamic>> files) async* {
  int totalSize = 0;
  int downloadedBytes = 0;

  // Calculate total size from files
  for (var file in files) {
    totalSize += int.parse(file['size']);
  }

  // List of streams to track download progress for each file
  List<Stream<int>> streams = files
      .map((file) =>
      downloadFile(file['url']!, file['name']!, int.parse(file['size'])))
      .toList();

  // Create a list to store previous progress for each file stream
  List<int> previousBytesList = List<int>.filled(files.length, 0);

  // Listen to all streams and accumulate progress
  for (int i = 0; i < streams.length; i++) {
    try {
      await for (int bytes in streams[i]) {
        // Calculate the difference (newly downloaded bytes) and add to the total
        int previousBytes = previousBytesList[i];
        int newBytes = bytes - previousBytes; // Only add the new chunk
        downloadedBytes += newBytes;

        // Update the previous bytes for this stream
        previousBytesList[i] = bytes;
        yield downloadedBytes / totalSize; // Emit cumulative progress as percentage
      }
    } catch (e) {
      // Rethrow the exception so the caller can handle it
      throw Exception('Error downloading file ${files[i]['name']}: $e');
    }
  }
}
