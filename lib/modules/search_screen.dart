import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/local/chash_helper.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';
import 'package:news_app/shared/cubit/app_states.dart';
import '../shared/components.dart';

class SearchScreen extends StatelessWidget {
  static FocusNode myFocusNode = FocusNode();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    myFocusNode.addListener(() {
      AppCubit.get(context).changeFocus();
    });
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = AppCubit.get(context).searchData;

        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                //search box
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    focusNode: myFocusNode,
                    style: TextStyle(color: AppCubit.get(context).darkMode! ? Colors.white : Colors.black),
                    controller: searchController,
                    decoration: InputDecoration(
                      label: Text(
                        'Search',
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (String value) {
                      CashHelper.putString('searchText', value);
                      AppCubit.get(context).getSearchData(value);
                    },
                    enabled: true,
                  ),
                ),
                //SizedBox(height: 20.0,),
                Expanded(child: articleBuilder(list, context, state),),
              ],
            )
        );
      },
    );
  }
}
