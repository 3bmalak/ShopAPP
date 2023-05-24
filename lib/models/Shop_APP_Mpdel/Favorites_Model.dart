class FavoritesModel {
  late bool status;
  late Data data;

  FavoritesModel({required this.status, required this.data});

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    print('hiiiiiiiiiiiiiii');
    status = json['status'];
    print('hiiiiiiiiiiiiiii');

    // message = json['message'];
    data =  Data.fromJson(json['data']) ;
    print('noooooooooooooo');

  }


}

class Data {
  late int currentPage;
   List<FavouriteData> data=[];
  late String firstPageUrl;
  late int from;
  late  int lastPage;
  late String lastPageUrl;
  // Null nextPageUrl;
  late  String path;
  late int perPage;
  late int to;
  late int total;


  Data.fromJson(Map<String, dynamic> json) {
    print('hiiiiiiiiiiiiiii');

    currentPage = json['current_page'];
    if (json['data'] != null) {

      json['data'].forEach((v) {
        data.add(new FavouriteData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }


}

class FavouriteData {
late  int id;
  Product? product;


   FavouriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }


}

class Product {
 late int id;
 dynamic price;
 dynamic oldPrice;
 late int discount;
 late String image;
 late String name;
 late String description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}