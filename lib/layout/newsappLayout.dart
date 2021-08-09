import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/controller/appCubit.dart';
import 'package:news_app_api/controller/cubit.dart';
import 'package:news_app_api/controller/states.dart';
import 'package:news_app_api/medouls/search/search_screen.dart';
import 'package:news_app_api/shared/componants/components.dart';
import 'package:news_app_api/shared/network/remote/dio_helper.dart';

class Newslayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    }),
                IconButton(
                    icon: Icon(Icons.brightness_4_outlined),
                    onPressed: () {
                      AppCubit.get(context).changeAppMode();
                    }),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        });
  }
}
