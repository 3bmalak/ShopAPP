import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/Network/End_Points/end_points.dart';
import 'package:shopapp/Shared/Network/Remote/Dio_Helper.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Login_Model.dart';
import 'State.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit():super(ShopRegisterInitState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  bool isPasswordIconChecked=true;
  late ShopLoginModel shopRegisterModel;

  void ChangePasswordVisability(){
    isPasswordIconChecked =! isPasswordIconChecked;
    emit(isPasswordIconCheckedRegisterState());
  }

  void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
}){

    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data:
      {
        'email':email,
        'password':password,
        'name':name,
        'phone':phone,
      },
    ).then((value) {
      print(value.data);
      shopRegisterModel=ShopLoginModel.Fromason(value.data);
      emit(ShopRegisterSuccessedtState(shopRegisterModel));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopRegisterErrortState(onError.toString()));
    });
  }

}