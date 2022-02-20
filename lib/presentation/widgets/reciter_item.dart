import 'package:flutter/material.dart';
import 'package:quran_17_2/data/cubit/quran_cubit.dart';

class ReciterItem extends StatelessWidget {
  final QuranCubit cubit;
  final int index;
  final List list;
  const ReciterItem(
      {Key? key, required this.cubit, required this.index, required this.list})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      height: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.teal.shade600,
          border: Border.all(width: 1, color: Colors.white)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: cubit.reciters.isNotEmpty && cubit.surahs.isNotEmpty
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(cubit.reciters[index].isFav!
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: () {
                          cubit.toggleIsFav(cubit.reciters[index]);
                        },
                      ),
                      Text(
                        cubit.isReciterPageOpened
                            ? list[index].titleAr
                            : list[index].name!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              child: Image.asset(
                "assets/images/border.png",
                height: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}