import 'dart:convert';

class RadioModel {
  late String name;
  late String url;
  late String id;
  late bool isPlay;
  late bool isFav;

  RadioModel(this.name, this.id, this.isFav, this.isPlay, this.url);
  RadioModel.fromJson(Map<String, dynamic> json) {
    name = json["Name"];
    url = json["URL"];
    id = json["id"];
    isPlay = json["bool"];
    isFav = json["fav"];
  }
  static Map<String, dynamic> toMap(RadioModel music) => {
        'id': music.id,
        'name': music.name,
        'URL': music.url,
        'bool': music.isPlay,
        'fav': music.isFav
      };
  static String encode(List<RadioModel> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => RadioModel.toMap(music))
            .toList(),
      );
  void toggleButton() {
    isPlay = true;
  }

  void toogleFavourite() {
    isFav = !isFav;
  }
}
