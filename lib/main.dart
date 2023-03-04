import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/network/local/chash_helper.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';
import 'package:news_app/shared/cubit/app_states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/network/remote/dio_helper.dart';

import 'modules/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CashHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getBusinessData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          bool darkMode = AppCubit.get(context).darkMode!;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white,
                  ),
                  color: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(color: Colors.black,)
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 20.0,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                type: BottomNavigationBarType.fixed,
              ),
            ),
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                iconColor: SearchScreen.myFocusNode.hasFocus ? Colors.deepOrange : Colors.grey,
                labelStyle: TextStyle(color: SearchScreen.myFocusNode.hasFocus ?
                Colors.deepOrange : Colors.grey[400],),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                    statusBarColor: Colors.black,
                  ),
                  color: Colors.black,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(color: Colors.white,)
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 20.0,
                backgroundColor: HexColor('282A3A'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey[400],
                type: BottomNavigationBarType.fixed,
              ),
            ),
            home: LayoutScreen(),
          );
        },
      ),
    );
  }
}