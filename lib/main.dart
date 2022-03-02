import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'app_router.dart';
import 'constants/observer.dart';
import 'constants/strings.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'core/db/boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox<int>("favouritesRadio").then((value) {
    favouritesRadios = Boxes.getRadioFavourites().values.toList();
  });
  await Hive.openBox<int>("favouritesReciter").then((value) {
    favouritesReciters = Boxes.getRecitersFavourites().values.toList();
  });

// ignore: prefer_const_constructors
  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Quran Mp3",
    notificationText: "سبحان الله و الحمدلله و لا اله الا الله و الله اكبر",
    notificationImportance: AndroidNotificationImportance.Default,
    enableWifiLock: true,
    notificationIcon: const AndroidResource(
        name: 'background_icon',
        defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );
  bool success =
      await FlutterBackground.initialize(androidConfig: androidConfig);
  FlutterBackground.enableBackgroundExecution().then((value) {
    BlocOverrides.runZoned(
      () {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
            .then((value) {
          runApp(MyApp(
            appRouter: AppRouter(),
          ));
        });
      },
      blocObserver: MyBlocObserver(),
    );
    if (!FlutterBackground.isBackgroundExecutionEnabled) {
      FlutterBackground.enableBackgroundExecution();
    }
  });
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  MyApp({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quran Mp3",
      theme: ThemeData(fontFamily: "a"),
      initialRoute: mainScreen,
      onGenerateRoute: appRouter.generateRoutes,
    );
  }
}
