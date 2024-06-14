import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DurationProgress extends StatefulWidget {
  final dynamic songProvider;
  const DurationProgress({super.key, required this.songProvider});

  @override
  State<DurationProgress> createState() => _DurationProgressState();
}

class _DurationProgressState extends State<DurationProgress> {
  //convert duratiob into min:sec
  String formatTime(Duration duration) {
    String twoDigiSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigiSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //start time
              Text(formatTime(widget.songProvider.currentDuration)),

              //shuffle
              IconButton(
                onPressed: widget.songProvider.shuffle,
                focusColor: Colors.blue,
                icon: Icon(
                  Icons.shuffle,
                ),
              ),

              //repeat icon
              IconButton(
                onPressed: widget.songProvider.repeat,
                icon: Icon(
                  Icons.repeat,
                  color: (widget.songProvider.isRepeat)
                      ? Colors.blue
                      : Colors.black,
                ),
              ),

              //end time
              Text(formatTime(widget.songProvider.totalDuration)),
            ],
          ),

          //song duration progress
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
            ),
            child: Slider(
              min: 0,
              max: widget.songProvider.totalDuration.inSeconds.toDouble(),
              value: widget.songProvider.currentDuration.inSeconds
                  .toDouble()
                  .clamp(0,
                      widget.songProvider.totalDuration.inSeconds.toDouble()),
              activeColor: Colors.green,
              onChanged: (double double) {
                //during when user is sliding around
                widget.songProvider.seek(Duration(seconds: double.toInt()));
              },
              onChangeEnd: (double double) {
                //sliding has finished, go to the position in song duration
                widget.songProvider.seek(Duration(seconds: double.toInt()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
