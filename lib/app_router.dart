import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_17_2/constants/strings.dart';
import 'package:quran_17_2/data/cubit/quran_cubit.dart';
import 'package:quran_17_2/data/json_reader/json_reader.dart';
import 'package:quran_17_2/data/models/reciter.dart';
import 'package:quran_17_2/data/repository/surahs_repository.dart';
import 'package:quran_17_2/presentation/pages/home.dart';
import 'package:quran_17_2/presentation/pages/main_screen.dart';
import 'package:quran_17_2/presentation/pages/reciter_page.dart';

QuranCubit? quranCubit;

class AppRouter {
  AppRouter() {
    quranCubit =
        QuranCubit(surahsRepository: SurahsRepository(reader: JsonReader()));
  }
  Route? generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case mainScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<QuranCubit>.value(
              value: quranCubit!
                ..getAllSurahs()
                ..getAllRecitersRadio()
                ..getAllReciters(),
              child: MainScreen(),
            );
          },
        );
      // case reciterPage:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       var reciter = routeSettings.arguments as int;
      //       return BlocProvider<QuranCubit>.value(
      //         value: quranCubit!,
      //         child: ReciterPage(
      //           reciterIndex: reciter,
      //         ),
      //       );
      //     },
      //   );
    }
  }
}
