class Reciter {
  final String? id;
  final String? name;
  final String? server;
  final String? rewaya;
  bool? isFav;
  final String? count;
  final String? letter;
  final String? suras;

  Reciter({
    this.id,
    this.name,
    this.server,
    this.rewaya,
    this.isFav,
    this.count,
    this.letter,
    this.suras,
  });

  Reciter.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        server = json['Server'] as String?,
        rewaya = json['rewaya'] as String?,
        isFav = json['isFav'] as bool?,
        count = json['count'] as String?,
        letter = json['letter'] as String?,
        suras = json['suras'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'Server': server,
        'rewaya': rewaya,
        'isFav': isFav,
        'count': count,
        'letter': letter,
        'suras': suras
      };
  toogleFavourite({bool? bl}) {
    isFav = bl ?? !isFav!;
  }
}
