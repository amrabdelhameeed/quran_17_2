import 'dart:convert';

import 'package:flutter/services.dart';

class JsonReader {
  Future<List<dynamic>> readJsonSurahs() async {
    final String response =
        await rootBundle.loadString('assets/jsons/surah.json');
    final data = await json.decode(response);
    return data["allSurahDetails"];
  }

  Future<List<dynamic>> readJsonReciters() async {
    final String response =
        await rootBundle.loadString('assets/jsons/reciters.json');
    final data = await json.decode(response);
    return data["reciters"];
  }

  Future<List<dynamic>> readJsonRecitersRadios() async {
    final String response =
        await rootBundle.loadString('assets/jsons/radios.json');
    final data = await json.decode(response);
    return data["Radios"];
  }
}
