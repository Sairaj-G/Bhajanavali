import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bhajanavali/components/button.dart';
import 'package:bhajanavali/components/functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AudioPlayer player = AudioPlayer();
bool repeat = false;

class AudioUI extends StatefulWidget {

  Duration? initial;
  Duration? end;
  bool _playing = false;
  AudioUI({this.initial, this.end});

  @override
  State<AudioUI> createState() => _AudioUIState();
}

class _AudioUIState extends State<AudioUI> {
  void initState(){
    super.initState();
    player.setAsset('assets/sound/bhanjan.mp3');
    player.seek(widget.initial!);
    player.setClip(start: widget.initial! , end : widget.end!);
  }

  @override
  void dispose(){
    player.stop();
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
            Container(
              height: 7/10*(screenHeight),
              width : 9.0/10*(screenWidth),
              child: Image.asset('assets/shreenath.JPEG'),
            ),

            Container(
              height: 1/10*(screenHeight),
              width: 9.0/10*screenWidth,
              child: StreamBuilder<Duration>(
                stream: player.positionStream,
                builder: (context, snapshot) {
                  final progress = (snapshot.data) ?? widget.initial;
                  final total = widget.end! - widget.initial!;

                  if(progress == total && repeat){
                      restart(player, widget.initial!, widget.end!);
                  }

                   return ProgressBar(
                      progress: progress!,
                      total: total,
                      onSeek: (duration) {
                        player.seek(duration);
                      },
                    );
                  },
                ),
            ),

              Container(
                height: 1/10*(screenHeight),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: CustomIcon(icon : Icons.fast_rewind),
                            onPressed:  () {fastRewind(player, widget.initial!, widget.end!);},
                        ),
                        IconButton(
                          icon: CustomIcon(icon: Icons.stop),
                          onPressed: () {
                            setState(() {
                              widget._playing = false;
                              stop(player, widget.initial!, widget.end!);
                            });
                          },
                        ),

                        IconButton(
                            icon: widget._playing
                                ? CustomIcon(icon: Icons.pause)
                                : CustomIcon(icon: Icons.play_arrow),
                            onPressed: () {
                              widget._playing
                                  ? player.pause()
                                  : player.play();
                              setState(() {
                                widget._playing = !widget._playing;
                              });
                            }),
                        IconButton(icon: repeat ? CustomIcon(icon : Icons.repeat_on_sharp) : CustomIcon(icon : Icons.repeat), onPressed: (){
                          setState(() {
                            repeat = !repeat;
                          });
                        }),
                        IconButton(icon: CustomIcon(icon: Icons.fast_forward), onPressed: (){fastForward(player, widget.end!, widget.initial!);})
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
