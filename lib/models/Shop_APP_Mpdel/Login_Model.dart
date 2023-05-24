class ShopLoginModel
{
 late bool status;
dynamic message;
  UserData? data;

  ShopLoginModel.Fromason(Map<String,dynamic> json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?  UserData.Fromason(json['data']):null;
  }

}
class UserData
{
  late int id;
  late String name;
  late String email;
  late String phone;
  dynamic credit;
  dynamic points;
   dynamic token;

  UserData.Fromason(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    credit=json['credit'];
    points=json['points'];
    token=json['token'];
  }
}