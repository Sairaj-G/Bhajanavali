import 'package:bhajanavali/screens/arati.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bhajanavali/components/button.dart';
import 'package:bhajanavali/components/functions.dart';

class AudioUI extends StatefulWidget {
  AudioPlayer? player;

  Duration? initial;
  Duration? end;

  bool _playing = false;

  AudioUI({this.player, this.initial, this.end});

  @override
  State<AudioUI> createState() => _AudioUIState();
}

class _AudioUIState extends State<AudioUI> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('assets/shreenath.JPEG'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
              child: StreamBuilder<Duration>(
                stream: widget.player!.positionStream,
                builder: (context, snapshot) {
                  final progress = (snapshot.data) ?? widget.initial;
                  final total = widget.end! - widget.initial!;


                  return ProgressBar(
                    progress: progress!,
                    total: total,
                    onSeek: (duration) {
                      widget.player!.seek(duration);
                    },
                  );
                },
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: CustomIcon(icon : Icons.fast_rewind),
                            onPressed:  () {fastRewind(widget.player!, widget.initial!, widget.end!);},
                        ),
                        IconButton(
                            icon: widget._playing
                                ? CustomIcon(icon: Icons.pause)
                                : CustomIcon(icon: Icons.play_arrow),
                            onPressed: () {
                              widget._playing
                                  ? widget.player!.pause()
                                  : widget.player!.play();
                              setState(() {
                                widget._playing = !widget._playing;
                              });
                            }),
                        IconButton(
                          icon: CustomIcon(icon: Icons.stop),
                          onPressed: () {
                            setState(() {
                              widget!._playing = false;
                              stop(widget.player!, widget.initial!, widget.end!);
                            });
                          },
                        ),
                        IconButton(icon: CustomIcon(icon: Icons.fast_forward), onPressed: (){fastForward(widget.player!, widget.end!, widget.initial!);}),
                      ],
                    ),
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
