import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_17_2/data/cubit/quran_cubit.dart';

class SurahItem extends StatelessWidget {
  final QuranCubit cubit;
  final int index;

  const SurahItem({
    Key? key,
    required this.cubit,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        return cubit.pageSurahs.isNotEmpty
            ? Container(
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Image.asset(
                          //   cubit.reciters.isNotEmpty
                          //       ? "assets/images/play.png"
                          //       : "assets/images/pause.png",
                          //   width: 30,
                          //   height: 30,
                          //   color: Colors.teal.shade100,
                          // ),
                          Text(
                            cubit.pageSurahs[index].titleAr,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
                              ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        child: Image.asset(
                          "assets/images/border.png",
                          height: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
