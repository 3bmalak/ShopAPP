class profileModel
{
  late bool status;
  late String message;
  profileData? data;
  profileModel.fromJson(Map<String, dynamic> json) {
    status=json['status'];
    message=json['message'];
    data=profileData.fromJson(json['data']);
  }
}
class profileData
{
  late int id;
  late String name;
  late String email;
  late int phone;
  late String image;
  late int points;
  late int credit;
  profileData.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];

  }
}