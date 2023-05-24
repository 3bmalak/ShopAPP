import 'package:flutter/material.dart';
ThemeData darkTheme=ThemeData(brightness: Brightness.dark,);


ThemeData lightTheme=ThemeData(
    // primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Janna',
    appBarTheme:AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      color: Colors.white,
      elevation: 0.0,
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      // selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black
        )
    )

);