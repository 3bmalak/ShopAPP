import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/Network/Remote/Dio_Helper.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Login_Model.dart';
import '../../../../Shared/Network/End_Points/end_points.dart';
import 'Shop_Login_State.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginInitState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  bool isPasswordIconChecked=true;


  void ChangePasswordVisability(){
    isPasswordIconChecked =! isPasswordIconChecked;
    emit(isPasswordIconCheckedLoginState());
  }

  void userLogin({
  required String email,
  required String password,
}){
    late ShopLoginModel shopLoginModel;


    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: Login,
        data:
      {
        'email':email,
        'password':password
      },
    ).then((value) {
      print(value.data);
      shopLoginModel=ShopLoginModel.Fromason(value.data);
      emit(ShopLoginSuccessedtState(shopLoginModel));
    }).catchError((onError){
      emit(ShopLoginErrortState(onError.toString()));
    });
  }
}