import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:quran_17_2/constants/strings.dart';
import 'package:quran_17_2/data/cubit/quran_cubit.dart';

class PlayerWidget extends StatelessWidget {
  PlayerWidget({Key? key, required this.cubit}) : super(key: key);
  final QuranCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: assetsAudioPlayer.builderRealtimePlayingInfos(
        builder: (context, realtimePlayingInfos) {
          return Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.teal,
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: assetsAudioPlayer.current != null
                ? Column(
                    children: [
                      Text(
                        realtimePlayingInfos.isBuffering
                            ? ""
                            : (assetsAudioPlayer.playlist!.numberOfItems == 1
                                ? cubit.radioReciter
                                : (cubit.curSurahName +
                                    "  " +
                                    cubit.reciters[cubit.curReciter].name!)),
                        style: const TextStyle(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (cubit.navBarIndex == 1) {
                                  assetsAudioPlayer.previous();
                                } else {
                                  cubit.playRadio(cubit.radioReciters
                                          .indexWhere((element) =>
                                              element.name ==
                                              cubit.radioReciter) -
                                      1);
                                }
                              },
                              icon: Icon(Icons.keyboard_backspace)),
                          IconButton(
                              onPressed: () {
                                assetsAudioPlayer.playOrPause();
                              },
                              icon: Icon(realtimePlayingInfos.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow)),
                          IconButton(
                              onPressed: () {
                                if (cubit.navBarIndex == 1) {
                                  assetsAudioPlayer.next();
                                } else {
                                  cubit.playRadio(cubit.radioReciters
                                          .indexWhere((element) =>
                                              element.name ==
                                              cubit.radioReciter) +
                                      1);
                                }
                              },
                              icon: Icon(Icons.navigate_next_rounded))
                        ],
                      )
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
