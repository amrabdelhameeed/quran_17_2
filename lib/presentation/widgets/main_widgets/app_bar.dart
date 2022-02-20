import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_17_2/data/cubit/quran_cubit.dart';

PreferredSizeWidget appBarWidget({required QuranCubit cubit}) {
  return AppBar(
    leading: cubit.isReciterPageOpened && cubit.navBarIndex == 1
        ? IconButton(
            onPressed: () {
              cubit.openOrCloseReciterPage(false);
            },
            icon: const Icon(Icons.arrow_back_rounded))
        : Container(),
    backgroundColor: Colors.teal,
    toolbarHeight: 50,
    title: Text(cubit.screensName[cubit.navBarIndex]),
    centerTitle: true,
  );
}
