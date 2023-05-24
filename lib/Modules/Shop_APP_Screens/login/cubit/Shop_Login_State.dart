import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Login_Model.dart';


abstract class ShopLoginStates{}
 class ShopLoginInitState extends ShopLoginStates{}
 class ShopLoginLoadingState extends ShopLoginStates{}
 class ShopLoginSuccessedtState extends ShopLoginStates{
  final ShopLoginModel loginModel;

  ShopLoginSuccessedtState(this.loginModel);
 }
 class ShopLoginErrortState extends ShopLoginStates
 {
 final String error;

  ShopLoginErrortState(this.error);
 }

class isPasswordIconCheckedLoginState extends ShopLoginStates{}

