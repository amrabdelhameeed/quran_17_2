// class SurahPageModel {
//   SurahPageModel({
//     required this.allPages,
//   });
//   late final List<AllPages> allPages;

//   SurahPageModel.fromJson(Map<String, dynamic> json) {
//     allPages =
//         List.from(json['allPages']).map((e) => AllPages.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['allPages'] = allPages.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

class Surahs {
  Surahs({
    required this.place,
    required this.type,
    required this.count,
    required this.revelationOrder,
    required this.rukus,
    required this.title,
    required this.titleAr,
    required this.titleEn,
    required this.index,
    required this.pages,
    required this.page,
    required this.start,
    required this.juz,
  });
  late final String place;
  late final String type;
  late final int count;
  late final int revelationOrder;
  late final int rukus;
  late final String title;
  late final String titleAr;
  late final String titleEn;
  late final String index;
  late final String pages;
  late final String page;
  late final int start;
  late final List<Juz> juz;

  Surahs.fromJson(Map<String, dynamic> json) {
    place = json['place'];
    type = json['type'];
    count = json['count'];
    revelationOrder = json['revelationOrder'];
    rukus = json['rukus'];
    title = json['title'];
    titleAr = json['titleAr'];
    titleEn = json['titleEn'];
    index = json['index'];
    pages = json['pages'];
    page = json['page'];
    start = json['start'];
    juz = List.from(json['juz']).map((e) => Juz.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['place'] = place;
    _data['type'] = type;
    _data['count'] = count;
    _data['revelationOrder'] = revelationOrder;
    _data['rukus'] = rukus;
    _data['title'] = title;
    _data['titleAr'] = titleAr;
    _data['titleEn'] = titleEn;
    _data['index'] = index;
    _data['pages'] = pages;
    _data['page'] = page;
    _data['start'] = start;
    _data['juz'] = juz.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Juz {
  Juz({
    required this.index,
    required this.verse,
  });
  late final String index;
  late final Verse verse;

  Juz.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    verse = Verse.fromJson(json['verse']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['index'] = index;
    _data['verse'] = verse.toJson();
    return _data;
  }
}

class Verse {
  Verse({
    required this.start,
    required this.end,
  });
  late final String start;
  late final String end;

  Verse.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start'] = start;
    _data['end'] = end;
    return _data;
  }
}
