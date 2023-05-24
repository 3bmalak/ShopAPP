import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Layout/Shop_APP/cubit/states.dart';
import 'package:shopapp/Shared/Network/Remote/Dio_Helper.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Change_Favorites_Model.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Favorites_Model.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Home_Model.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Login_Model.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/categories_Model.dart';
import '../../../Modules/Shop_APP_Screens/Categories/Categories.dart';
import '../../../Modules/Shop_APP_Screens/Favorites/favourites_screen.dart';
import '../../../Modules/Shop_APP_Screens/Products/Products_Screen.dart';
import '../../../Modules/Shop_APP_Screens/Settings/Settings_Screen.dart';
import '../../../Shared/Components/Component.dart';
import '../../../Shared/Network/End_Points/end_points.dart';





class ShopAppCubit extends Cubit<ShopAppStates>
{
  ShopAppCubit() : super(ShopAppInitState());
  static ShopAppCubit get(context) => BlocProvider.of(context);
  int CurrentIndix=0;
  List <Widget> Screen=
  [
   ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];
  void changeScreen({required int indix})
  {
  CurrentIndix=indix;
  // if(CurrentIndix==3){
  //  getProfileData();
  // }if(CurrentIndix==1){
  //  getCategoryData();
  // }if(CurrentIndix==2){
  //  getFavoritesData();
  // }

  emit(ShopAppBottomNavState());
  }

  HomeModel? homeModel;
  Map<dynamic, dynamic> favorites = {};

  void getHomeData(){
    emit(ShopLoadingHomeState());
    DioHelper.getData(
        url: Home,
        token: token
    ).
    then((value)
    {
      homeModel=HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites
        });
      });

      emit(ShopSuccessHomeState());
    }
    ).catchError((onError){
     print(onError.toString());
      emit(ShopErrorHomeState(onError.toString()));
    });

  }

   CategoriesModel? categoriesModel;
  void getCategoryData(){
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
        url: Categories,
        token: token
    ).
    then((value)
    {
       categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }
    ).catchError((onError){
     print(onError.toString());
      emit(ShopErrorCategoriesState(onError.toString()));
    });

  }
  //
  // void changeFavouriteState(ProductsModel product)
  // {
  //   product.inFavorites = product.inFavorites;
  // }

  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavouritesState(int id)
  {
    favorites[id]=!favorites[id];
    emit(ShopChangeFavouriteState());
    DioHelper.postData(
        url: Favorites,
        token: token,
        data: {
          'product_id':id
        }).then((value)
    {
          changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
          print(value.data);
          if(!changeFavoritesModel.status)
          {
            favorites[id]=!favorites[id];
          }
          else
            getFavoritesData();
            emit(ShopSuccessFavoritesState(changeFavoritesModel));

         })
        .catchError((onError)
    {
      favorites[id]=!favorites[id];
      print(onError.toString());
    emit(ShopErrorFavoritesState(onError));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData(){
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(
        url: Favorites,
        token: token
    ).
    then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      print(favoritesModel!.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }
    ).catchError((onError){
      print(onError.toString());
      emit(ShopErrorGetFavoritesState(onError.toString()));
    });

  }
  ShopLoginModel? profilemodel;
  void getProfileData(){
    emit(ShopSuccessGetProfileState());
    DioHelper.getData(
        url: PROFILE,
        token: token
    ).
    then((value)
    {
      profilemodel=ShopLoginModel.Fromason(value.data);
      print(profilemodel!.data.toString());
      emit(ShopSuccessGetProfileState());
    }
    ).catchError((onError){
      print(onError.toString());
      emit(ShopErrorGetProfileState(onError.toString()));
    });

  }

  void updateProfileData
  ({
  required String updateName,
  required String updateEmail,
  required String updatePhone,
  })
{
    emit(ShopuUpdateUserLoadingState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data:
        {
          'name':updateName,
          'email': updateEmail ,
          'phone': updatePhone
        }
    ).
    then((value)
    {
      profilemodel=ShopLoginModel.Fromason(value.data);
      print(profilemodel!.data.toString());
      emit(ShopuUpdateUserSuccessedtState(profilemodel!));
    }
    ).catchError((onError){
      print(onError.toString());
      emit(ShopuUpdateUserErrortState(onError.toString()));
    });

  }
}

