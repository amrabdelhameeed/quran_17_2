import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/cubit/quran_cubit.dart';

class ReciterItem extends StatelessWidget {
  final QuranCubit cubit;
  final int index;
  final List list;
  const ReciterItem(
      {Key? key, required this.cubit, required this.index, required this.list})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = QuranCubit.get(context);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.teal.shade600,
              border: Border.all(width: 1, color: Colors.white)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Image.asset(
                      "assets/images/border.png",
                      height: 35,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    child: Image.asset(
                      "assets/images/border.png",
                      height: 35,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Image.asset(
                      "assets/images/border.png",
                      height: 35,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  child: Image.asset(
                    "assets/images/border.png",
                    height: 35,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 8),
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: cubit.reciters.isNotEmpty && cubit.surahs.isNotEmpty
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !cubit.isReciterPageOpened
                              ? Expanded(
                                  child: IconButton(
                                    icon: Icon(
                                      (cubit.navBarIndex == 0
                                              ? ((cubit.isSearch
                                                      ? (!cubit.isFavourite
                                                          ? cubit.searchedRadios
                                                          : cubit.searchedRadios
                                                              .where((element) =>
                                                                  element.isFav)
                                                              .toList())
                                                      : (!cubit.isFavourite
                                                              ? cubit
                                                                  .radioReciters
                                                              : cubit.radioReciters
                                                                  .where((element) => element
                                                                      .isFav)
                                                                  .toList())
                                                          .toList())[index]
                                                  .isFav)
                                              : (cubit.isSearch
                                                      ? (!cubit.isFavourite
                                                          ? cubit
                                                              .searchedReciters
                                                          : cubit.searchedReciters
                                                              .where((element) => element
                                                                  .isFav!)
                                                              .toList())
                                                      : (!cubit.isFavourite
                                                          ? cubit.reciters
                                                          : cubit.reciters
                                                              .where((element) => element.isFav!)
                                                              .toList()))[index]
                                                  .isFav!)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      cubit.toggleIsFav(index);
                                    },
                                  ),
                                )
                              : Container(),
                          Expanded(
                            flex: 8,
                            child: Text(
                              cubit.isReciterPageOpened
                                  ? list[index].titleAr
                                  : list[index].name!,
                              maxLines: 1,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
