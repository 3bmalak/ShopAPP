
import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/states.dart';

import 'Layout/Shop_APP/Shop_Layout.dart';
import 'Layout/Shop_APP/cubit/cubit.dart';
import 'Modules/Shop_APP_Screens/login/Shop_Login_Screen.dart';
import 'Modules/Shop_APP_Screens/onBoardingScreen/on_boardingScreen.dart';
import 'Shared/Network/End_Points/end_points.dart';
import 'Shared/Network/Remote/Dio_Helper.dart';
import 'Shared/Network/local/cache_Helper.dart';
import 'Shared/Style/Colors/Themes.dart';
import 'Shared/block_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  var onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding==true){
    if(token!=''){
      widget=ShopLayout();
    }
    else widget=ShopLoginScreen();
  }
  else{
    widget=onBoardingScreen();
  }
  print(onBoarding);
  runApp(MyApp( widget));
}

class MyApp extends StatelessWidget {

  late Widget startWidget;

  MyApp( this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [


      BlocProvider(
        create:(context) =>ShopAppCubit()..getHomeData()..getCategoryData()..getFavoritesData()..getProfileData(),),

    ],
      child: BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context, state)
        {

        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget ,
          );
        },
      ),
    );
  }
}
