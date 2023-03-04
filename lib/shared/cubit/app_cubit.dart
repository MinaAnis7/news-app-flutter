import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/app_states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import '../../network/local/chash_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool? darkMode = CashHelper.getBoolean('isDark') ?? false;

  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List businessData = [];
  List sportsData = [];
  List scienceData = [];
  List searchData = [];

  void navBarChange(index){
    currentIndex = index;
    emit(NavBarChangeIndexState());

    if(currentIndex == 0)
      getBusinessData();
    else if(currentIndex == 1)
      getSportsData();
    else if(currentIndex == 2)
      getScienceData();
  }


  void getBusinessData()
  {
    emit(GetBusinessLoadingState());

     DioHelper.get(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg',
          'category' : 'business',
          'apiKey' : '6b23166f73b94170b7372c57837cc04d'
        },).then((value) {
          businessData = value.data['articles'];
          emit(GetBusinessDataSuccessState());
     }).catchError((error){
       emit(GetBusinessDataErrorState());
       print(error);
     });
  }
  void getSportsData()
  {
    emit(GetSportsLoadingState());

     DioHelper.get(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg',
          'category' : 'sports',
          'apiKey' : 'e38cac22591e41fd88da4077477462ef'
        },).then((value) {
       sportsData = value.data['articles'];
          emit(GetSportsDataSuccessState());
     }).catchError((error){
       emit(GetSportsDataErrorState());
       print(error);
     });
  }
  void getScienceData()
  {
    emit(GetScienceLoadingState());

     DioHelper.get(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg',
          'category' : 'science',
          'apiKey' : 'e38cac22591e41fd88da4077477462ef'
        },).then((value) {
          scienceData = value.data['articles'];
          print('business: $businessData');
          emit(GetScienceDataSuccessState());
     }).catchError((error){
       emit(GetScienceDataErrorState());
       print(error);
     });
  }
  void getSearchData(String value)
  {
    emit(GetSearchLoadingState());

   DioHelper.get(
      url: 'v2/everything',
      query:
      {
        'q' : '$value',
        'apiKey' : 'e38cac22591e41fd88da4077477462ef'
      },

   ).then((value) {

        searchData = value.data['articles'];
        emit(GetSearchDataSuccessState());

     }).catchError((error){
       print(error);
       emit(GetSearchDataErrorState());
     });
  }

  void changeMode()
  {
    darkMode = !darkMode!;
    CashHelper.putBoolean('isDark', darkMode!);
    emit(ChangeMode());
  }

  void changeFocus()
  {
    emit(ChangeFocus());
  }


}