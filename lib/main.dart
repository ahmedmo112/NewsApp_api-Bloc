import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_api/controller/states.dart';
import 'package:news_app_api/shared/bloc_observer.dart';
import 'package:news_app_api/layout/newsappLayout.dart';
import 'dart:ui' as ui;
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_api/shared/network/local/cache_helper.dart';
import 'package:news_app_api/shared/network/remote/dio_helper.dart';

import 'controller/appCubit.dart';
import 'controller/appStates.dart';
import 'controller/cubit.dart';

void main() async {
//! if we did main async we must add => WidgetsFlutterBinding.ensureInitialized();
//!    and this mean  make sure that do all before RunApp() then runApp
//! بيتاكد ان كل حاجه هنا في الميثود خلصت وبعدين يفتح الابلكيشن

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHeler.init();

  bool isDark = CacheHeler.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;

  const MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness(),),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark))
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'News',
            //! //////////// //app theme ////////
            //* //////Light////////////
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.dark,
                      statusBarColor: Colors.white),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.black)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            //* //////Dark////////////
            darkTheme: ThemeData(
              
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.light,
                      statusBarColor: HexColor('333739')),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.white)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              scaffoldBackgroundColor: HexColor('333739'),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            //! ///////////////////////////////
            debugShowCheckedModeBanner: false,
            home: Directionality(
                textDirection: ui.TextDirection.ltr, child: Newslayout()),
          );
        },
      ),
    );
  }
}
