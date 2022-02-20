// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quran_17_2/constants/strings.dart';
// import 'package:quran_17_2/data/cubit/quran_cubit.dart';
// import 'package:quran_17_2/presentation/widgets/reciter_item.dart';

// class Home extends StatelessWidget {
//   Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<QuranCubit, QuranState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = QuranCubit.get(context);
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.teal,
//             toolbarHeight: 50,
//             title: Text(
//               "الشيوخ",
//               // style: TextStyle(fontSize: 20),
//             ),
//             centerTitle: true,
//           ),
//           backgroundColor: Colors.teal.shade200,
//           body: Column(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: cubit.reciters.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                         onTap: () {
//                           Navigator.pushNamed(context, reciterPage,
//                               arguments: index);
//                         },
//                         child: ReciterItem(cubit: cubit, index: index));
//                   },
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: assetsAudioPlayer.builderRealtimePlayingInfos(
//                   builder: (context, realtimePlayingInfos) {
//                     return Container(
//                       width: double.infinity,
//                       height: 200,
//                       decoration: BoxDecoration(
//                           color: Colors.teal,
//                           border: Border.all(
//                             width: 2,
//                             color: Colors.white,
//                           ),
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15))),
//                       child: realtimePlayingInfos.current != null
//                           ? Column(
//                               children: [
//                                 Text(
//                                   "${cubit.reciters[cubit.curReciter].name}   " +
//                                       cubit
//                                           .pageSurahs[realtimePlayingInfos
//                                               .current!.index]
//                                           .titleAr,
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     IconButton(
//                                         onPressed: () {
//                                           assetsAudioPlayer.previous();
//                                         },
//                                         icon: Icon(Icons.keyboard_backspace)),
//                                     IconButton(
//                                         onPressed: () {
//                                           assetsAudioPlayer.playOrPause();
//                                         },
//                                         icon: Icon(
//                                             realtimePlayingInfos.isPlaying
//                                                 ? Icons.pause
//                                                 : Icons.play_arrow)),
//                                     IconButton(
//                                         onPressed: () {
//                                           assetsAudioPlayer.next();
//                                         },
//                                         icon: Icon(Icons.navigate_next_rounded))
//                                   ],
//                                 )
//                               ],
//                             )
//                           : Container(),
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
