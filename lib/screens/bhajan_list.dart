import 'package:bhajanavali/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:bhajanavali/components/bhajan_time_map.dart';
import 'package:bhajanavali/components/audio_ui.dart';


class BhajanListScreen extends StatefulWidget {
  const BhajanListScreen({Key? key}) : super(key: key);

  @override
  State<BhajanListScreen> createState() => _BhajanListScreenState();
}

class _BhajanListScreenState extends State<BhajanListScreen> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        child: ListView.builder(
          itemCount : bhajanTitles.length,
          itemBuilder: (BuildContext context, int index){
            return Container(

              height: screenHeight/12,
              width: screenWidth,

              child: Card(
                color: Colors.yellow,
                child : ListTile(
                  title: Text(bhajanTitles[index], style: TextStyle(fontSize: responsiveDimensionResize(20, screenWidth, screenHeight))),
                  subtitle: Text((bhajanEndDurations[index]-bhajanStartDurations[index]).toString().split('.').first.padLeft(1), style: TextStyle(fontSize: responsiveDimensionResize(12, screenWidth, screenHeight))),

                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AudioUI(initial : bhajanStartDurations[index],
                            end : bhajanEndDurations[index], audioLink: audioURL[index], bhajanIndex : index )));
                    print(audioURL[index]);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
