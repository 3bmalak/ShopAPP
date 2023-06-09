
class HomeModel
{
late bool status;
 String? message;
 HomeDataModel? data;

HomeModel.fromJson(Map<String,dynamic> json)
{
  status=json['status'];
  message=json['message'];
  data= HomeDataModel.fromJson(json['data']);
}
}

class HomeDataModel
{

  List<BannersModel> banners=[];
  List<ProductsModel> products=[];

  HomeDataModel.fromJson(Map<String,dynamic> json)
  {

    json['products'].forEach((element)
    {
      products.add( ProductsModel.fromJson(element));
    }
    );

    json['banners'].forEach((element)
    {
      banners.add( BannersModel.fromJson(element));
    }
    );
  }
}

class BannersModel
{
  late int id;
   String? image;

  BannersModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    image=json['image'];
  }
}

class ProductsModel
{
   late int id;
   dynamic price ;
   dynamic oldPrice;
   dynamic discount;
   String? image;
   String? name;
   late bool inFavorites;
   bool? inCart;

  ProductsModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}