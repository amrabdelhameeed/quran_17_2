import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/strings.dart';
import '../../../data/cubit/quran_cubit.dart';

PreferredSizeWidget appBarWidget({required QuranCubit cubit}) {
  return AppBar(
    leading: cubit.isReciterPageOpened && cubit.navBarIndex == 1
        ? IconButton(
            onPressed: () {
              cubit.openOrCloseReciterPage(false);
            },
            icon: const Icon(Icons.arrow_back_rounded))
        : IconButton(
            onPressed: () {
              cubit.changeFavourite();
            },
            icon: Icon(
                cubit.isFavourite ? Icons.favorite : Icons.favorite_border)),
    actions: [
      IconButton(
          onPressed: () {
            textEditingController.clear();
            cubit.changeSearch();
          },
          icon: Icon(cubit.isSearch ? Icons.close : Icons.search_rounded))
    ],
    backgroundColor: Colors.teal,
    toolbarHeight: 50,
    title: !cubit.isSearch
        ? (Text(!cubit.isReciterPageOpened
            ? cubit.screensName[cubit.navBarIndex]
            : cubit.getter().name!))
        : TextFormField(
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            controller: textEditingController,
            onChanged: (value) {
              cubit.search(value);
            },
            onFieldSubmitted: (value) {
              cubit.closeSearch();
            },
          ),
    centerTitle: true,
  );
}
