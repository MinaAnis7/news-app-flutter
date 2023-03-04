import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';
import 'package:news_app/shared/cubit/app_states.dart';

import '../modules/search_screen.dart';
import '../shared/components.dart';

class LayoutScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News App',
              ),
              actions: [
                //Search button
                IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen(),);
                    },
                    icon: Icon(
                      Icons.search,
                      size: 28.0,
                    )
                ),
                IconButton(
                    onPressed: (){
                      cubit.changeMode();
                    },
                    icon: Icon(
                      Icons.brightness_4_rounded,
                      size: 28.0,
                    )),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.navItems,
              onTap: (index)
              {
                cubit.navBarChange(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
    );
  }

}