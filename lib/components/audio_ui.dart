import 'package:bhajanavali/components/constants.dart';
import 'package:bhajanavali/main.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bhajanavali/components/widgets.dart';
import 'package:bhajanavali/components/functions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

bool repeat = false;
bool result = false;

class AudioUI extends StatefulWidget {
  String? bhajanTitle = "|| ||";
  int? index;
  bool changeInIndex = false;
  InternetConnectivityService? internetConnectivityService;

  AudioUI(int index) {
    this.index = index;
    internetConnectivityService = InternetConnectivityService();
    if (this.index != bhajanPLayer!.bhajanIndex) {
      bhajanPLayer!.bhajanIndex = this.index;
      bhajanPLayer!.loadCurrentBhajanHelper();
      changeInIndex = true;
    } else {}
  }

  @override
  State<AudioUI> createState() => _AudioUIState();
}

class _AudioUIState extends State<AudioUI> {
  void initState() {
    result = false;
    super.initState();
    bhajanPLayer!
        .pause(); //Setting this to handle the edge case of a new bhajan being played while something other was being played.
    widget.bhajanTitle =
        "|| " + bhajanTitles[bhajanPLayer!.bhajanIndex!].toString() + " ||";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      bhajanPLayer!.playPrevBhajan(context);
                    },
                    child: Icon(Icons.arrow_back_ios)),
                Text(widget.bhajanTitle!,
                    style: TextStyle(
                        fontSize: responsiveDimensionResize(
                            20, screenWidth, screenHeight),
                        fontWeight: FontWeight.bold)),
                TextButton(
                    onPressed: () {
                      bhajanPLayer!.playNextBhajan(context);
                    },
                    child: Icon(Icons.arrow_forward_ios))
              ],
            ),
            Container(
              height: 7.0 / 10 * (screenHeight),
              width: 9.0 / 10 * (screenWidth),
              child: Image.asset('assets/shreenath.JPEG'),
            ),
            Container(
              height: 1 / 10 * (screenHeight),
              width: 9.0 / 10 * screenWidth,
              child: StreamBuilder<Duration>(
                stream: bhajanPLayer!.player!.positionStream,
                builder: (context, snapshot) {
                  final progress =
                      (snapshot.data) ?? bhajanStartDurations[widget.index!];
                  final total = bhajanEndDurations[widget.index!] -
                      bhajanStartDurations[widget.index!];

                  if (progress == total && repeat) {
                    bhajanPLayer!.restart();
                  }

                  return ProgressBar(
                    progress: progress!,
                    total: total,
                    timeLabelTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: responsiveDimensionResize(
                            15, screenWidth, screenHeight)),
                    onSeek: (duration) async {
                      await bhajanPLayer!.seek(duration);
                    },
                  );
                },
              ),
            ),
            Container(
              height: 1 / 10 * (screenHeight),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: CustomTextIcon(text: "-5"),
                        onPressed: () {
                          bhajanPLayer!.fastRewind();
                        },
                      ),
                      IconButton(
                        icon: CustomIcon(icon: Icons.stop),
                        onPressed: () {
                          setState(() {
                            bhajanPLayer!.stopAndReset();
                          });
                        },
                      ),
                      IconButton(
                          icon: bhajanPLayer!.player!.playing
                              ? CustomIcon(icon: Icons.pause)
                              : CustomIcon(icon: Icons.play_arrow),
                          onPressed: () async {
                            bhajanPLayer!.player!.playing
                                ? bhajanPLayer!.pause()
                                : bhajanPLayer!.play();
                            setState(() {});
                          }),
                      IconButton(
                          icon: repeat
                              ? CustomIcon(icon: Icons.repeat_on_sharp)
                              : CustomIcon(icon: Icons.repeat),
                          onPressed: () {
                            setState(() {
                              repeat = !repeat;
                            });
                          }),
                      IconButton(
                          icon: CustomTextIcon(text: "+5"),
                          onPressed: () {
                            bhajanPLayer!.fastForward();
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
