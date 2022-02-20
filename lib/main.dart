import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_17_2/app_router.dart';
import 'package:quran_17_2/constants/observer.dart';
import 'package:quran_17_2/constants/strings.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  MyApp({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: mainScreen,
      onGenerateRoute: appRouter.generateRoutes,
    );
  }
}
