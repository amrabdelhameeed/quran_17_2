import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_17_2/data/cubit/quran_cubit.dart';

Widget bottomNavBar(QuranCubit cubit) {
  return BottomNavigationBar(
    backgroundColor: Colors.teal.shade200,
    currentIndex: cubit.navBarIndex,
    onTap: (ind) {
      cubit.changeNavBarIndex(ind);
    },
    selectedItemColor: Colors.teal,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.radio), label: "Radio"),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: "Reciters"),
    ],
  );
}
