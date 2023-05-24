


import 'package:shopapp/models/Shop_APP_Mpdel/Change_Favorites_Model.dart';
import 'package:shopapp/models/Shop_APP_Mpdel/Login_Model.dart';

abstract class ShopAppStates{}

class ShopAppInitState extends ShopAppStates{}
class ShopAppBottomNavState extends ShopAppStates{}

class ShopLoadingHomeState extends ShopAppStates{}
class ShopSuccessHomeState extends ShopAppStates{}
class ShopErrorHomeState extends ShopAppStates{
  final String Error;
  ShopErrorHomeState(this.Error);
}

class ShopLoadingCategoriesState extends ShopAppStates{}
class ShopSuccessCategoriesState extends ShopAppStates{}
class ShopErrorCategoriesState extends ShopAppStates{
  final String Error;
  ShopErrorCategoriesState(this.Error);
}

class ShopChangeFavouriteState extends ShopAppStates{}

class ShopSuccessFavoritesState extends ShopAppStates{
  final ChangeFavoritesModel changeFavoritesModel;

  ShopSuccessFavoritesState(this.changeFavoritesModel);
}
class ShopErrorFavoritesState extends ShopAppStates{
  final String Error;
  ShopErrorFavoritesState(this.Error);
}

class ShopSuccessGetFavoritesState extends ShopAppStates{}
class ShopLoadingFavoritesState extends ShopAppStates{}
class ShopErrorGetFavoritesState extends ShopAppStates{
  final String Error;
  ShopErrorGetFavoritesState(this.Error);
}



class ShopSuccessGetProfileState extends ShopAppStates{}
class ShopLoadingProfileState extends ShopAppStates{}
class ShopErrorGetProfileState extends ShopAppStates{
  final String Error;
  ShopErrorGetProfileState(this.Error);
}
class ShopuUpdateUserLoadingState extends ShopAppStates{}
class ShopuUpdateUserSuccessedtState extends ShopAppStates{
  final ShopLoginModel loginModel;

  ShopuUpdateUserSuccessedtState(this.loginModel);
}
class ShopuUpdateUserErrortState extends ShopAppStates
{
  final String error;

  ShopuUpdateUserErrortState(this.error);
}
