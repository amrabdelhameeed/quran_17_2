import 'package:flutter/material.dart';
import '../../../data/cubit/quran_cubit.dart';
import '../reciter_item.dart';

class ListViewBuilder extends StatelessWidget {
  ListViewBuilder({Key? key, required this.cubit, required this.list})
      : super(key: key);
  final QuranCubit cubit;
  final List list;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 12,
      child: list.isNotEmpty
          ? ListView.builder(
              controller: cubit.scrollController,
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      if (cubit.navBarIndex == 1 &&
                          !cubit.isReciterPageOpened) {
                        if (cubit.isSearch) {
                          if (!cubit.isFavourite) {
                            cubit
                                .getListOfAudios(cubit.searchedReciters[index]);
                          } else {
                            cubit.getListOfAudios(cubit.searchedReciters
                                .where((element) => element.isFav!)
                                .toList()[index]);
                          }
                        } else {
                          if (!cubit.isFavourite) {
                            cubit.getListOfAudios(cubit.reciters[index]);
                          } else {
                            cubit.getListOfAudios(cubit.reciters
                                .where((element) => element.isFav!)
                                .toList()[index]);
                          }
                        }
                        cubit.openOrCloseReciterPage(true);
                      } else if (cubit.navBarIndex == 1 &&
                          cubit.isReciterPageOpened) {
                        // print(cubit.curReciter);
                        cubit.play(index);
                      } else if (cubit.navBarIndex == 0) {
                        cubit.playRadio(index);
                      }
                    },
                    child: ReciterItem(cubit: cubit, index: index, list: list));
              },
            )
          : Center(
              child: Column(
                children: [
                  Image.asset("assets/images/notfound.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "لا يوجد نتائج :(",
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  )
                ],
              ),
            ),
    );
  }
}

/*
 cubit.navBarIndex == 1
            ? (!cubit.isReciterPageOpened
                ? cubit.reciters.length
                : cubit.pageSurahs.length)
            : cubit.radioReciters.length,
*/
/*
cubit.navBarIndex == 1
                  ? (!cubit.isReciterPageOpened
                      ? ReciterItem(cubit: cubit, index: index)
                      : SurahItem(cubit: cubit, index: index))
                  : RadioItem(cubit: cubit, index: index));
 */