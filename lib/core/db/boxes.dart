import 'package:hive/hive.dart';

class Boxes {
  static Box<int> getRadioFavourites() => Hive.box<int>("favouritesRadio");
  static Box<int> getRecitersFavourites() => Hive.box<int>("favouritesReciter");
}
