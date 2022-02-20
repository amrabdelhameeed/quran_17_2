import 'package:flutter/material.dart';
import 'package:quran_17_2/data/cubit/quran_cubit.dart';
import 'package:quran_17_2/presentation/widgets/reciter_item.dart';

class ListViewBuilder extends StatelessWidget {
  ListViewBuilder({Key? key, required this.cubit, required this.list})
      : super(key: key);
  final QuranCubit cubit;
  final List list;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                if (cubit.navBarIndex == 1 && !cubit.isReciterPageOpened) {
                  cubit.getListOfAudios(cubit.reciters[index]);
                  cubit.openOrCloseReciterPage(true);
                } else if (cubit.navBarIndex == 1 &&
                    cubit.isReciterPageOpened) {
                  print(cubit.curReciter);
                  cubit.play(cubit.curReciter, index);
                } else if (cubit.navBarIndex == 0) {
                  cubit.playRadio(index);
                }
              },
              child: ReciterItem(cubit: cubit, index: index, list: list));
        },
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