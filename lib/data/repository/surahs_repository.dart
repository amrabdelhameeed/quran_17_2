import 'package:quran_17_2/data/json_reader/json_reader.dart';
import 'package:quran_17_2/data/models/radio.dart';
import 'package:quran_17_2/data/models/reciter.dart';
import 'package:quran_17_2/data/models/surah_model.dart';

class SurahsRepository {
  final JsonReader reader;
  SurahsRepository({required this.reader});
  Future<List<Surahs>> readJsonAsModel() async {
    List<dynamic> data = [];
    await reader.readJsonSurahs().then((value) {
      data = value;
    });
    return data.map((e) => Surahs.fromJson(e)).toList();
  }

  Future<List<Reciter>> readJsonAsModelForReciters() async {
    List<dynamic> data = [];
    await reader.readJsonReciters().then((value) {
      data = value;
    });
    return data.map((e) => Reciter.fromJson(e)).toList();
  }

  Future<List<RadioModel>> readJsonAsModelForRecitersRadio() async {
    List<dynamic> data = [];
    await reader.readJsonRecitersRadios().then((value) {
      data = value;
    });
    return data.map((e) => RadioModel.fromJson(e)).toList();
  }
}
