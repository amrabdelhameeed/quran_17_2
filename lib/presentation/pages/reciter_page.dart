// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quran_17_2/app_router.dart';
// import 'package:quran_17_2/constants/strings.dart';
// import 'package:quran_17_2/data/cubit/quran_cubit.dart';
// import 'package:quran_17_2/data/models/reciter.dart';
// import 'package:quran_17_2/presentation/widgets/surah_item.dart';

// class ReciterPage extends StatelessWidget {
//   int pageIndex = 0;
//   final int reciterIndex;
//   ReciterPage({Key? key, required this.reciterIndex}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var cubit = QuranCubit.get(context);
//     Reciter reciter = cubit.reciters[reciterIndex];
//     quranCubit!.surahsNames(reciter);
//     return BlocConsumer<QuranCubit, QuranState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = QuranCubit.get(context);
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.teal,
//             toolbarHeight: 50,
//             title: Text(reciter.name!),
//           ),
//           backgroundColor: Colors.teal.shade200,
//           body: Column(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: cubit.pageSurahs.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         //cubit.play(reciterIndex, index, assetsAudioPlayer);
//                       },
//                       child: SurahItem(
//                         cubit: cubit,
//                         index: index,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: assetsAudioPlayer.builderRealtimePlayingInfos(
//                   builder: (context, realtimePlayingInfos) {
//                     if (realtimePlayingInfos.isBuffering) {}
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
//                       child: Column(
//                         children: [
//                           Text(
//                             cubit
//                                 .pageSurahs[realtimePlayingInfos.current!.index]
//                                 .titleAr,
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                   onPressed: () {
//                                     assetsAudioPlayer.previous();
//                                   },
//                                   icon: Icon(Icons.keyboard_backspace)),
//                               IconButton(
//                                   onPressed: () {
//                                     assetsAudioPlayer.playOrPause();
//                                   },
//                                   icon: Icon(realtimePlayingInfos.isPlaying
//                                       ? Icons.pause
//                                       : Icons.play_arrow)),
//                               IconButton(
//                                   onPressed: () {
//                                     assetsAudioPlayer.next();
//                                   },
//                                   icon: Icon(Icons.navigate_next_rounded))
//                             ],
//                           )
//                         ],
//                       ),
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
