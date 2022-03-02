import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/strings.dart';
import '../../../data/cubit/quran_cubit.dart';

class PlayerWidget extends StatelessWidget {
  PlayerWidget({Key? key, required this.cubit}) : super(key: key);
  final QuranCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Expanded(
          flex: 3,
          child: cubit.assetsAudioPlayer != null
              ? cubit.assetsAudioPlayer!.builderRealtimePlayingInfos(
                  builder: (context, realtimePlayingInfos) {
                    if (realtimePlayingInfos.current != null &&
                        realtimePlayingInfos
                                .current!.audio.audio.audioType.index ==
                            0) {
                      cubit
                          .changeSurahName(realtimePlayingInfos.current!.index);
                    }
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
                      child: Column(
                        children: [
                          Text(
                            realtimePlayingInfos.isBuffering
                                ? ""
                                : ((cubit.assetsAudioPlayer!.playlist!
                                                .numberOfItems ==
                                            1 &&
                                        cubit.assetsAudioPlayer!.current
                                            .isBroadcast)
                                    ? cubit.radioReciter
                                    : (cubit.curSurahName +
                                        "  -  " +
                                        (!cubit.isSearch
                                            ? cubit.curReciter!.name!
                                            : cubit.curReciter!.name!))),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.teal,
                                radius: 20,
                                backgroundImage:
                                    const AssetImage("assets/images/back.png"),
                                child: InkWell(
                                  onTap: () {
                                    if (realtimePlayingInfos
                                            .current!.playlist.audios.length >
                                        1) {
                                      cubit.assetsAudioPlayer!.previous();
                                      //     .then((value) {
                                      //   cubit.changeSurahName(cubit
                                      //       .assetsAudioPlayer!
                                      //       .current
                                      //       .value!
                                      //       .index);
                                      // });
                                    } else {
                                      cubit.playRadio(cubit.radioReciters
                                              .indexWhere((element) =>
                                                  element.name ==
                                                  cubit.radioReciter) -
                                          1);
                                    }
                                  },
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.teal,
                                radius: 20,
                                backgroundImage: realtimePlayingInfos.isPlaying
                                    ? const AssetImage(
                                        "assets/images/pause.png")
                                    : const AssetImage(
                                        "assets/images/play.png"),
                                child: InkWell(
                                  onTap: () {
                                    cubit.assetsAudioPlayer!.playOrPause();
                                  },
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.teal,
                                radius: 20,
                                backgroundImage:
                                    const AssetImage("assets/images/next.png"),
                                child: InkWell(
                                  onTap: () {
                                    if (realtimePlayingInfos
                                            .current!.playlist.audios.length >
                                        1) {
                                      cubit.assetsAudioPlayer!.next();
                                      //     .then((value) {
                                      //   cubit.changeSurahName(
                                      //       realtimePlayingInfos
                                      //           .current!.index);
                                      // });
                                      // if (cubit.isSearch) {}
                                    } else {
                                      cubit.playRadio(cubit.radioReciters
                                              .indexWhere((element) =>
                                                  element.name ==
                                                  cubit.radioReciter) +
                                          1);
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                )
              : SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: InkWell(
                      enableFeedback: false,
                      child: const Text(
                        "اختيار عشوائي",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        cubit.shuffleAudios();
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }
}
