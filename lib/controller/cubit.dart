import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/controller/states.dart';
import 'package:news_app_api/medouls/busienss/busienss_screen.dart';
import 'package:news_app_api/medouls/science/science_screen.dart';
import 'package:news_app_api/medouls/settings_screen/settings_screen.dart';
import 'package:news_app_api/medouls/sports/sports_screens.dart';
import 'package:news_app_api/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of<NewsCubit>(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottonNavState());
  }

  List<dynamic> business = [];

  List<dynamic> search = [];

  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    
    DioHelper.getData(url: 'v2/everything', query: {
        'q': '$value',
        'apiKey': '9956cb70360f40e3a14806c92f5ba72f'
      }).then((value) {
        //  print(value.data['articles'][1]['title']);
        search = value.data['articles'];
        print(search[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
  }




  void getBusiness() {
    emit(NewsGetBusinesLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '9956cb70360f40e3a14806c92f5ba72f'
    }).then((value) {
      //  print(value.data['articles'][1]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      print("error");

      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '9956cb70360f40e3a14806c92f5ba72f'
      }).then((value) {
        //  print(value.data['articles'][1]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.length ==0) {
       DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '9956cb70360f40e3a14806c92f5ba72f'
    }).then((value) {
      //  print(value.data['articles'][1]['title']);
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
    }else {
      emit(NewsGetScienceSuccessState());
    }

   
  }
}
