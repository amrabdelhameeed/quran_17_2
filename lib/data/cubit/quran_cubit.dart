import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_17_2/constants/strings.dart';
import 'package:quran_17_2/data/models/radio.dart';
import 'package:quran_17_2/data/models/reciter.dart';
import 'package:quran_17_2/data/models/surah_model.dart';
import 'package:quran_17_2/data/repository/surahs_repository.dart';
part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final SurahsRepository surahsRepository;
  QuranCubit({required this.surahsRepository}) : super(QuranInitial());
  static QuranCubit get(context) => BlocProvider.of(context);
  List<Surahs> surahs = [];
  List<Surahs> pageSurahs = [];
  List<Reciter> reciters = [];
  List<String> screensName = ["Radios", "Reciters"];
  List<RadioModel> radioReciters = [];
  List<Audio> audios = [];
  List<Surahs> searchedSurahs = [];
  List<Reciter> searchedReciters = [];
  List<RadioModel> searchedRadios = [];
  int curReciter = 0;
  int navBarIndex = 0;
  // List<List<Surahs>> allSurahsOfPages = [];
  // List<List<Audio>> allSurahsAudios = [];
  bool isReciterPageOpened = false;
  bool isSearch = false;
  List search(String searchedName) {
    searchedReciters.clear();
    searchedRadios.clear();
    searchedSurahs.clear();
    isSearch = true;
    if (navBarIndex == 1 && !isReciterPageOpened) {
      reciters.forEach((radio) {
        if (radio.name!.contains(searchedName)) {
          searchedReciters.add(radio);
        }
      });
    } else if (navBarIndex == 1 && isReciterPageOpened) {
      pageSurahs.forEach((radio) {
        if (radio.titleAr.contains(searchedName)) {
          searchedSurahs.add(radio);
        }
      });
    } else {
      radioReciters.forEach((radio) {
        if (radio.name.contains(searchedName)) {
          searchedRadios.add(radio);
        }
      });
    }

    emit(SearchState());
    return radioReciters;
  }

  void closeSearch() {
    isSearch = false;
    emit(SearchState());
  }

  void getAllSurahs() {
    surahsRepository.readJsonAsModel().then((value) {
      surahs = value;
      emit(SurahsLoaded(surahs));
    });
  }

  void getAllReciters() async {
    surahsRepository.readJsonAsModelForReciters().then((value) {
      reciters = value;
      emit(RecitersLoaded(reciters));
    });
  }

  void getAllRecitersRadio() {
    surahsRepository.readJsonAsModelForRecitersRadio().then((allReciters) {
      radioReciters = allReciters;
      emit(QuranLoaded(allReciters));
    });
  }

  void changeNavBarIndex(int index) {
    if (index == 0) {
      isReciterPageOpened = false;
    }
    navBarIndex = index;
    emit(ChangeNavBarIndexState());
  }

  Future<List<int>> getSurahsOfReciter(String reciterSuras) async {
    return reciterSuras.split(",").map((e) => int.parse(e)).toList();
  }

  Future<List<Surahs>> surahsNames(Reciter reciter) async {
    pageSurahs = [];
    _curReciter = reciters.indexWhere((e) => e == reciter);
    getSurahsOfReciter(reciter.suras!).then((value) {
      for (var numOfSurah in value) {
        pageSurahs.add(
            surahs.firstWhere((surah) => int.parse(surah.index) == numOfSurah));
      }
    });
    return pageSurahs;
  }

  // List<List<String>> listOfSurahsOfThePage = [];

  // Future<void> getlistOfSurahsOfThePage() async {
  //   if (listOfSurahsOfThePage.isEmpty) {
  //     reciters.forEach((reciter) {
  //       surahsNames(reciter).then((listOfInts) {
  //         listOfSurahsOfThePage.add(listOfInts);
  //       });
  //     });
  //   }
  //   //print(listOfSurahsOfThePage.first);
  //   emit(GetAudiosSuccess());
  // }

  // void getAllAudiosFinal() {
  //   if (allSurahsAudios.isEmpty) {
  //     reciters.forEach((reciter) {
  //       listOfSurahsOfThePage.forEach((page) {
  //         allSurahsAudios.add(getListOfAudios(reciter, page));
  //       });
  //     });
  //   }
  // }
  // void getAllSurahsName() {
  //   getAllReciters().then((value) {
  //     value.forEach((reciter) {
  //       surahsNames(reciter).then((surahs) {
  //         allSurahsOfPages.add(surahs);
  //       });
  //     });
  //     value.forEach((recister) {
  //       allSurahsOfPages.forEach((surahsOfPage) {
  //         allSurahsAudios.add(getListOfAudios(recister, surahsOfPage));
  //       });
  //     });
  //   });
  // }

  // void getAllAudios() {
  //   reciters.forEach((reciter) {
  //     allSurahsOfPages.forEach((surahsOfPage) {
  //       allSurahsAudios.add(getListOfAudios(reciter, surahsOfPage));
  //     });
  //   });
  // }

  void toggleIsFav(Reciter reciter) {
    reciter.toogleFavourite();
    emit(FavouriteState());
  }

  void getListOfAudios(
    Reciter reciter,
  ) {
    surahsNames(reciter).then((value) {
      audios = List<Audio>.generate(
          value.length,
          (index) =>
              Audio.network("${reciter.server!}/${value[index].index}.mp3"));
    });
  }

  int _curReciter = 0;
  String curSurahName = "";
  void play(
    int reciterIndex,
    int index,
  ) {
    // curReciter = _curReciter;
    // curSurahName = pageSurahs[index].titleAr;
    // assetsAudioPlayer.open(Playlist(audios: audios, startIndex: index),
    //     showNotification: true);
    if (isSearch) {
      curReciter = _curReciter;
      curSurahName = searchedSurahs[index].titleAr;
      assetsAudioPlayer.open(
          Playlist(
            audios: audios,
            startIndex: pageSurahs
                .indexWhere((element) => element.titleAr == curSurahName),
          ),
          showNotification: true);
    } else {
      curReciter = _curReciter;
      curSurahName = pageSurahs[index].titleAr;
      assetsAudioPlayer.open(Playlist(audios: audios, startIndex: index),
          showNotification: true);
    }
  }

  String radioReciter = "";
  void playRadio(int indexOfRadio) {
    if (!isSearch) {
      radioReciter = radioReciters[indexOfRadio].name;
      assetsAudioPlayer.open(Audio.liveStream(radioReciters[indexOfRadio].url),
          showNotification: true,
          notificationSettings: const NotificationSettings(
              nextEnabled: false, prevEnabled: false, playPauseEnabled: true));
    } else {
      radioReciter = searchedRadios[indexOfRadio].name;
      assetsAudioPlayer.open(Audio.liveStream(searchedRadios[indexOfRadio].url),
          showNotification: true,
          notificationSettings: const NotificationSettings(
              nextEnabled: false, prevEnabled: false, playPauseEnabled: true));
    }
  }

  void openOrCloseReciterPage(bool bl) {
    isReciterPageOpened = bl;
    isSearch = false;
    emit(OpenOrCloseReciterPage());
  }
}
