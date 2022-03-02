import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';
import 'data/cubit/quran_cubit.dart';
import 'data/json_reader/json_reader.dart';
import 'data/repository/surahs_repository.dart';
import 'presentation/pages/main_screen.dart';

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
