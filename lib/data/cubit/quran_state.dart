part of 'quran_cubit.dart';

@immutable
abstract class QuranState {}

class QuranInitial extends QuranState {}

class SurahsListPage extends QuranState {}

class SearchState extends QuranState {}

class OpenOrCloseReciterPage extends QuranState {}

class ChangeNavBarIndexState extends QuranState {}

class FavouriteState extends QuranState {}

class GetAudiosSuccess extends QuranState {}

class SurahsLoaded extends QuranState {
  final List<Surahs> surahs;
  SurahsLoaded(this.surahs);
}

class RecitersLoaded extends QuranState {
  final List<Reciter> reciters;
  RecitersLoaded(this.reciters);
}

class QuranLoaded extends QuranState {
  final List<RadioModel> radioReciters;
  QuranLoaded(this.radioReciters);
}
