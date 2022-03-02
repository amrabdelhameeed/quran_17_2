import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../data/cubit/quran_cubit.dart';

Widget bottomNavBar(QuranCubit cubit) {
  return BottomNavigationBar(
    backgroundColor: Colors.teal.shade200,
    currentIndex: cubit.navBarIndex,
    onTap: (ind) {
      cubit.changeNavBarIndex(ind);
    },
    unselectedItemColor: Colors.teal,
    selectedItemColor: Colors.white,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.radio), label: "راديو"),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: "القراء"),
    ],
  );
}
