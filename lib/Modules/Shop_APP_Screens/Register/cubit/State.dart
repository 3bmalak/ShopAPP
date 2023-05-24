import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Login_Model.dart';


abstract class ShopRegisterStates{}
 class ShopRegisterInitState extends ShopRegisterStates{}
 class ShopRegisterLoadingState extends ShopRegisterStates{}
 class ShopRegisterSuccessedtState extends ShopRegisterStates{
  final ShopLoginModel loginModel;

  ShopRegisterSuccessedtState(this.loginModel);
 }
 class ShopRegisterErrortState extends ShopRegisterStates
 {
 final String error;

  ShopRegisterErrortState(this.error);
 }

class isPasswordIconCheckedRegisterState extends ShopRegisterStates{}

