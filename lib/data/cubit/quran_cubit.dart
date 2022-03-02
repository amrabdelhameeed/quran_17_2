import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../constants/strings.dart';
import '../../core/db/boxes.dart';
import '../models/radio.dart';
import '../models/reciter.dart';
import '../models/surah_model.dart';
import '../repository/surahs_repository.dart';
part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final SurahsRepository surahsRepository;
  QuranCubit({required this.surahsRepository}) : super(QuranInitial());
  static QuranCubit get(context) => BlocProvider.of(context);
  List<Surahs> surahs = [];
  List<Surahs> pageSurahs = [];
  List<Reciter> reciters = [];
  List<String> screensName = ["راديو", "القراء"];
  List<RadioModel> radioReciters = [];
  List<Audio> audios = [];
  List<Surahs> searchedSurahs = [];
  AssetsAudioPlayer? assetsAudioPlayer;
  ScrollController? scrollController = ScrollController();
  List<Reciter> searchedReciters = [];
  List<RadioModel> searchedRadios = [];
  Reciter? curReciter;
  int navBarIndex = 0;
  // List<List<Surahs>> allSurahsOfPages = [];
  // List<List<Audio>> allSurahsAudios = [];
  bool isReciterPageOpened = false;
  bool isSearch = false;
  bool isFavourite = false;

  void changeSearch() {
    isSearch = !isSearch;
    emit(SearchState());
  }

  void changeFavourite() {
    isFavourite = !isFavourite;
    emit(FavouriteFilter());
  }

  void search(String searchedName) {
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
  }

  void closeSearch() {
    isSearch = false;
    textEditingController.clear();
    searchedReciters.clear();
    searchedRadios.clear();
    searchedSurahs.clear();
    emit(SearchState());
  }

  // void changeSearchValue(String value) {
  //   searchedChar = value;
  //   emit(SearchState());
  // }

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

  Future<List<RadioModel>> getAllRecitersRadio() async {
    surahsRepository.readJsonAsModelForRecitersRadio().then((allReciters) {
      radioReciters = allReciters;
      emit(QuranLoaded(allReciters));
    });
    return radioReciters;
  }

  void favouriteForAllRadios() {
    print("iam In");
    if (radioReciters.isNotEmpty) {
      print("iam In");

      favouritesRadios!.forEach((fav) {
        radioReciters[radioReciters
                .indexWhere((element) => int.parse(element.id) == fav)]
            .toogleFavourite(bl: true);
      });
    }
    if (reciters.isNotEmpty) {
      print("iam In");

      favouritesReciters!.forEach((fav) {
        reciters[
                reciters.indexWhere((element) => int.parse(element.id!) == fav)]
            .toogleFavourite(bl: true);
      });
    }
  }

  void changeNavBarIndex(int index) {
    scrollController!.animateTo(scrollController!.position.minScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);
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
    _curReciter = reciter;
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

  void toggleIsFav(int index) {
    if (navBarIndex == 0) {
      if (isFavourite) {
        final box = Boxes.getRadioFavourites();
        if (!isSearch) {
          if (!radioReciters
              .where((element) => element.isFav)
              .toList()[index]
              .isFav) {
            favouritesRadios!.add(int.parse(radioReciters
                .where((element) => element.isFav)
                .toSet()
                .toList()[index]
                .id));
            box.put(
                radioReciters
                    .where((element) => element.isFav)
                    .toSet()
                    .toList()[index]
                    .id,
                int.parse(radioReciters
                    .where((element) => element.isFav)
                    .toSet()
                    .toList()[index]
                    .id));
          } else {
            if (favouritesRadios!.isNotEmpty) {
              favouritesRadios!.remove(int.parse(radioReciters
                  .where((element) => element.isFav)
                  .toSet()
                  .toList()[index]
                  .id));
              box.delete(radioReciters
                  .where((element) => element.isFav)
                  .toSet()
                  .toList()[index]
                  .id);
            }
          }
          radioReciters
              .where((element) => element.isFav)
              .toSet()
              .toList()[index]
              .toogleFavourite();
        } else {
          searchedRadios[index].toogleFavourite();
          if (searchedRadios[index].isFav) {
            favouritesRadios!.add(int.parse(searchedRadios[index].id));
            box.put(
                searchedRadios[index].id, int.parse(searchedRadios[index].id));
          } else {
            if (favouritesRadios!.isNotEmpty) {
              favouritesRadios!.remove(int.parse(searchedRadios[index].id));
              box.delete(searchedRadios[index].id);
            }
          }
        }
        emit(FavouriteState());

        print(favouritesRadios!);
      } else {
        final box = Boxes.getRadioFavourites();
        if (!isSearch) {
          radioReciters[index].toogleFavourite();
          if (radioReciters[index].isFav) {
            favouritesRadios!.add(int.parse(radioReciters[index].id));
            box.put(
                radioReciters[index].id, int.parse(radioReciters[index].id));
          } else {
            if (favouritesRadios!.isNotEmpty) {
              favouritesRadios!.remove(int.parse(radioReciters[index].id));
              box.delete(radioReciters[index].id);
            }
          }
        } else {
          searchedRadios[index].toogleFavourite();
          if (searchedRadios[index].isFav) {
            favouritesRadios!.add(int.parse(searchedRadios[index].id));
            box.put(
                searchedRadios[index].id, int.parse(searchedRadios[index].id));
          } else {
            if (favouritesRadios!.isNotEmpty) {
              favouritesRadios!.remove(int.parse(searchedRadios[index].id));
              box.delete(searchedRadios[index].id);
            }
          }
        }
        emit(FavouriteState());

        print(favouritesRadios!);
      }
    } else {
      if (isFavourite) {
        final box = Boxes.getRecitersFavourites();
        if (!isSearch) {
          if (!reciters
              .where((element) => element.isFav!)
              .toList()[index]
              .isFav!) {
            favouritesReciters!.add(int.parse(reciters
                .where((element) => element.isFav!)
                .toList()[index]
                .id!));
            box.put(
                reciters.where((element) => element.isFav!).toList()[index].id,
                int.parse(reciters
                    .where((element) => element.isFav!)
                    .toList()[index]
                    .id!));
          } else {
            if (favouritesReciters!.isNotEmpty) {
              favouritesReciters!.remove(int.parse(reciters
                  .where((element) => element.isFav!)
                  .toList()[index]
                  .id!));
              box.delete(reciters
                  .where((element) => element.isFav!)
                  .toList()[index]
                  .id);
            }
          }
          reciters
              .where((element) => element.isFav!)
              .toList()[index]
              .toogleFavourite();
        } else {
          searchedReciters[index].toogleFavourite();
          if (searchedReciters[index].isFav!) {
            favouritesReciters!.add(int.parse(searchedReciters[index].id!));
            box.put(searchedReciters[index].id,
                int.parse(searchedReciters[index].id!));
          } else {
            if (favouritesReciters!.isNotEmpty) {
              favouritesReciters!
                  .remove(int.parse(searchedReciters[index].id!));
              box.delete(searchedReciters[index].id);
            }
          }
          emit(FavouriteState());
          reciters[index].toogleFavourite();
        }
        print(favouritesReciters!);
      } else {
        final box = Boxes.getRecitersFavourites();
        if (!isSearch) {
          reciters[index].toogleFavourite();
          if (reciters[index].isFav!) {
            favouritesReciters!.add(int.parse(reciters[index].id!));
            box.put(reciters[index].id, int.parse(reciters[index].id!));
          } else {
            if (favouritesReciters!.isNotEmpty) {
              favouritesReciters!.remove(int.parse(reciters[index].id!));
              box.delete(reciters[index].id);
            }
          }
        } else {
          searchedReciters[index].toogleFavourite();
          if (searchedReciters[index].isFav!) {
            favouritesReciters!.add(int.parse(searchedReciters[index].id!));
            box.put(searchedReciters[index].id,
                int.parse(searchedReciters[index].id!));
          } else {
            if (favouritesReciters!.isNotEmpty) {
              favouritesReciters!
                  .remove(int.parse(searchedReciters[index].id!));
              box.delete(searchedReciters[index].id);
            }
          }
          emit(FavouriteState());
        }
        print(favouritesReciters!);
      }
    }
    emit(FavouriteState());
  }

  void getListOfAudios(
    Reciter reciter,
  ) {
    surahsNames(reciter).then((value) {
      _curReciter = reciter;

      if (isSearch) {
        audios = List<Audio>.generate(
            searchedSurahs.length,
            (index) => Audio.network(
                "${reciter.server!}/${searchedSurahs[index].index}.mp3"));
      } else {
        audios = List<Audio>.generate(
            value.length,
            (index) =>
                Audio.network("${reciter.server!}/${value[index].index}.mp3"));
      }
    });
  }

  int curIndexFOrSurah = -1;
  void changeSurahName(int index) {
    if (curIndexFOrSurah != index) {
      if (isSearch) {
        curSurahName = searchedSurahs[index].titleAr;
      } else {
        curSurahName = pageSurahs[index].titleAr;
      }
      emit(SearchState());
      curIndexFOrSurah = index;
      assetsAudioPlayer!.updateCurrentAudioNotification(
        metas: Metas(
          album: curReciter!.name,
          title: curSurahName,
          onImageLoadFail: const MetasImage.asset(
            "assets/images/radio.png",
          ),
          image: const MetasImage.asset("assets/images/radioaa.jpg"),
        ),
      );
    }
  }

  Reciter? _curReciter;

  Reciter getter() => _curReciter!;
  String curSurahName = "";
  void shuffleAudios() {
    playRadio(Random().nextInt(radioReciters.length - 1));
  }

  void play(
    int index,
  ) {
    setAudioPlayer();
    curReciter = _curReciter;
    // curReciter = _curReciter;
    // curSurahName = pageSurahs[index].titleAr;
    // assetsAudioPlayer.open(Playlist(audios: audios, startIndex: index),
    //     showNotification: true);
    if (isSearch) {
      curSurahName = searchedSurahs[index].titleAr;

      assetsAudioPlayer!
          .open(
        Playlist(
          audios: audios,
          startIndex: pageSurahs
              .indexWhere((element) => element.titleAr == curSurahName),
        ),
        showNotification: true,
        notificationSettings: NotificationSettings(
        stopEnabled: false,

        )
      )
          .then((value) {
        assetsAudioPlayer!.updateCurrentAudioNotification(
          metas: Metas(
            album: curReciter!.name,
            title: curSurahName,
            onImageLoadFail: const MetasImage.asset(
              "assets/images/radio.png",
            ),
            image: const MetasImage.asset("assets/images/radioaa.jpg"),
          ),
        );
      });
    } else {
      curReciter = _curReciter;
      curSurahName = pageSurahs[index].titleAr;

      assetsAudioPlayer!
          .open(
        Playlist(
            audios: audios,
            startIndex: pageSurahs
                .indexWhere((element) => element.titleAr == curSurahName)),
        showNotification: true,
      )
          .then((value) {
        assetsAudioPlayer!.updateCurrentAudioNotification(
          metas: Metas(
            album: curReciter!.name,
            title: curSurahName,
            onImageLoadFail: const MetasImage.asset(
              "assets/images/radio.png",
            ),
            image: const MetasImage.asset("assets/images/radioaa.jpg"),
          ),
        );
      });
    }
  }

  void setAudioPlayer() {
    assetsAudioPlayer = assetsAudioPlayer ?? AssetsAudioPlayer.withId("id5");
    emit(SetAudioPlayer());
  }

  String radioReciter = "";
  void playRadio(int indexOfRadio) {
    setAudioPlayer();
    if (!isSearch) {
      if (isFavourite) {
        radioReciter = radioReciters
            .where((element) => element.isFav)
            .toList()[indexOfRadio]
            .name;
        assetsAudioPlayer!.open(
            Audio.liveStream(radioReciters
                .where((element) => element.isFav)
                .toList()[indexOfRadio]
                .url),
            showNotification: true,
            notificationSettings: const NotificationSettings(
                stopEnabled: false,
                nextEnabled: false,
                prevEnabled: false,
                playPauseEnabled: true));
      } else {
        radioReciter = radioReciters[indexOfRadio].name;
        assetsAudioPlayer!.open(
            Audio.liveStream(
              radioReciters[indexOfRadio].url,
              metas: Metas(
                album: radioReciter,
                title: radioReciter,
                onImageLoadFail: const MetasImage.asset(
                  "assets/images/radio.png",
                ),
                image: const MetasImage.asset("assets/images/radioaa.jpg"),
              ),
            ),
            showNotification: true,
            notificationSettings: const NotificationSettings(
                stopEnabled: false,
                nextEnabled: false,
                prevEnabled: false,
                playPauseEnabled: true));
      }
    } else {
      if (isFavourite) {
        radioReciter = radioReciters
            .where((element) => element.isFav)
            .toList()[indexOfRadio]
            .name;
        assetsAudioPlayer!.open(
            Audio.liveStream(radioReciters
                .where((element) => element.isFav)
                .toList()[indexOfRadio]
                .url),
            showNotification: true,
            notificationSettings: const NotificationSettings(
                nextEnabled: false,
                stopEnabled: false,
                prevEnabled: false,
                playPauseEnabled: true));
      } else {
        radioReciter = searchedRadios[indexOfRadio].name;
        assetsAudioPlayer!.open(
            Audio.liveStream(searchedRadios[indexOfRadio].url),
            showNotification: true,
            notificationSettings: const NotificationSettings(
                nextEnabled: false,
                stopEnabled: false,
                prevEnabled: false,
                playPauseEnabled: true));
      }
    }
  }

  void openOrCloseReciterPage(bool bl) {
    isReciterPageOpened = bl;
    isSearch = false;
    emit(OpenOrCloseReciterPage());
  }
}
