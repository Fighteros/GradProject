class LoginModel {
  late bool status;
  late String message;
  late UserData data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;
  late int point;
  late int credit;

  // UserData(
  //     {required this.id,
  //      required this.name,
  //      required this.email,
  //      required this.phone,
  //      required this.image,
  //      required this.token,
  //      required this.point,
  //      required this.credit,
  //     }
  //     );

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    credit = json['credit'];
    point = json['point'];
  }
}
