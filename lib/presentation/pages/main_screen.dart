import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_17_2/data/cubit/quran_cubit.dart';
import 'package:quran_17_2/presentation/widgets/main_widgets/app_bar.dart';
import 'package:quran_17_2/presentation/widgets/main_widgets/bottom_nav_bar.dart';
import 'package:quran_17_2/presentation/widgets/main_widgets/list_view_builder.dart';
import 'package:quran_17_2/presentation/widgets/main_widgets/player_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = QuranCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            cubit.openOrCloseReciterPage(false);
            return false;
          },
          child: Scaffold(
            bottomNavigationBar: bottomNavBar(cubit),
            appBar: appBarWidget(cubit: cubit),
            backgroundColor: Colors.teal.shade200,
            body: Column(
              children: [
                TextFormField(
                  controller: textEditingController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      cubit.search(value);
                    } else {
                      cubit.closeSearch();
                    }
                  },
                ),
                ListViewBuilder(
                  cubit: cubit,
                  list: cubit.navBarIndex == 1
                      ? (!cubit.isReciterPageOpened
                          ? (textEditingController.text.isEmpty
                              ? cubit.reciters
                              : cubit.searchedReciters)
                          : (textEditingController.text.isEmpty
                              ? cubit.pageSurahs
                              : cubit.searchedSurahs))
                      : (textEditingController.text.isEmpty
                          ? cubit.radioReciters
                          : cubit.searchedRadios),
                ),
                PlayerWidget(cubit: cubit)
              ],
            ),
          ),
        );
      },
    );
  }
}
