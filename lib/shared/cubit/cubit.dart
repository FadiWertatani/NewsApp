import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/modules/business/business.dart';
import 'package:new_app/modules/science/science.dart';
import 'package:new_app/modules/settings/settings.dart';
import 'package:new_app/modules/sports/sports.dart';
import 'package:new_app/shared/cubit/states.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = const [
     BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_basketball),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      label: 'settings',
    ),
  ];

  void changeIndex(int index){
    currentIndex = index;
    if(index == 1) getSports();
    if(index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'business',
        'apiKey':'38e19f21515247bd9ec9dc8f0605d532',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }

  List<dynamic> sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());

    if(sports.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'sports',
          'apiKey':'38e19f21515247bd9ec9dc8f0605d532',
        },
      ).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());

    if(science.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'science',
          'apiKey':'38e19f21515247bd9ec9dc8f0605d532',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }

}