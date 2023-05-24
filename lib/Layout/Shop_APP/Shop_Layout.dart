import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/cubit.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/states.dart';
import '../../Modules/Shop_APP_Screens/Search/Search_Screen.dart';
import '../../Shared/Components/Component.dart';




class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {


        var cubit=ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'TOT'
            ),
            actions: [
              IconButton(onPressed: () {
                navigatorTo(context, SearchScreen());
              },
              icon: Icon(Icons.search),)
            ],
          ),
          body: cubit.Screen[cubit.CurrentIndix],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cubit.changeScreen(indix: value);
            },
            currentIndex: cubit.CurrentIndix,
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.home) ,
                  label: "Home"
              ),
              BottomNavigationBarItem(icon:Icon(Icons.apps) ,
                  label: "Categories"
              ),
              BottomNavigationBarItem(icon:Icon(Icons.favorite) ,
                  label: "Favorite"
              ),
              BottomNavigationBarItem(icon:Icon(Icons.settings) ,
                  label: "Settings"
              ),
            ],

          ),
        );
      },

    );
  }
}
