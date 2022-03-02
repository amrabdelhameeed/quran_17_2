import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../data/cubit/quran_cubit.dart';
import '../widgets/main_widgets/app_bar.dart';
import '../widgets/main_widgets/bottom_nav_bar.dart';
import '../widgets/main_widgets/list_view_builder.dart';
import '../widgets/main_widgets/player_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(listener: (context, state) {
      var cubit = QuranCubit.get(context);

      if (state is QuranLoaded) {
        cubit.favouriteForAllRadios();
      }
      if (state is RecitersLoaded) {
        cubit.favouriteForAllRadios();
      }
    }, builder: (context, state) {
      var cubit = QuranCubit.get(context);

      return WillPopScope(
          onWillPop: () async {
            cubit.openOrCloseReciterPage(false);
            return false;
          },
          child: OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;
                return Scaffold(
                    bottomNavigationBar: connected ? bottomNavBar(cubit) : null,
                    appBar: appBarWidget(cubit: cubit),
                    backgroundColor: Colors.teal.shade200,
                    body: connected
                        ? Column(
                            children: [
                              ListViewBuilder(
                                cubit: cubit,
                                list: cubit.navBarIndex == 1
                                    ? (!cubit.isReciterPageOpened
                                        ? (!cubit.isSearch
                                            ? (!cubit.isFavourite
                                                ? cubit.reciters
                                                : cubit.reciters
                                                    .where((element) =>
                                                        element.isFav!)
                                                    .toList())
                                            : (!cubit.isFavourite
                                                ? cubit.searchedReciters
                                                : cubit.searchedReciters
                                                    .where((element) =>
                                                        element.isFav!)
                                                    .toList()))
                                        : (!cubit.isSearch
                                            ? cubit.pageSurahs
                                            : cubit.searchedSurahs))
                                    : (!cubit.isSearch
                                        ? (!cubit.isFavourite
                                            ? cubit.radioReciters
                                            : cubit.radioReciters
                                                .where(
                                                    (element) => element.isFav)
                                                .toList())
                                        : (!cubit.isFavourite
                                            ? cubit.searchedRadios
                                            : cubit.searchedRadios
                                                .where(
                                                    (element) => element.isFav)
                                                .toList())),
                              ),
                              PlayerWidget(cubit: cubit)
                            ],
                          )
                        : Center(
                            child: Column(
                              children: [
                                Image.asset("assets/images/notfound.png"),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "لا يوجد اتصال بالانترنت :(",
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                )
                              ],
                            ),
                          ));
              },
              child: Container()));
    });
  }
}
/*
Center(
                          child: Column(
                            children: [
                              Image.asset("assets/images/notfound.png"),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "لا يوجد اتصال بالانترنت :(",
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              )
                            ],
                          ),
                        );
                  ;
                },
                child: Container())

 */


/*
Column(
              children: [
                ListViewBuilder(
                  cubit: cubit,
                  list: cubit.navBarIndex == 1
                      ? (!cubit.isReciterPageOpened
                          ? (!cubit.isSearch
                              ? (!cubit.isFavourite
                                  ? cubit.reciters
                                  : cubit.reciters
                                      .where((element) => element.isFav!)
                                      .toList())
                              : (!cubit.isFavourite
                                  ? cubit.searchedReciters
                                  : cubit.searchedReciters
                                      .where((element) => element.isFav!)
                                      .toList()))
                          : (!cubit.isSearch
                              ? cubit.pageSurahs
                              : cubit.searchedSurahs))
                      : (!cubit.isSearch
                          ? (!cubit.isFavourite
                              ? cubit.radioReciters
                              : cubit.radioReciters
                                  .where((element) => element.isFav)
                                  .toList())
                          : (!cubit.isFavourite
                              ? cubit.searchedRadios
                              : cubit.searchedRadios
                                  .where((element) => element.isFav)
                                  .toList())),
                ),
                PlayerWidget(cubit: cubit)
              ],
            )
 */