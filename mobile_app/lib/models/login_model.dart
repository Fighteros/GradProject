class LoginModel {
  String? accessToken;
  String? tokenType;
  User? user;

  LoginModel({this.accessToken, this.tokenType, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? age;
  String? phoneNumber;
  String? jobTitle;
  int? userLevelId;
  String? createdAt;
  String? updatedAt;
  Image? image;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.age,
      this.phoneNumber,
      this.jobTitle,
      this.userLevelId,
      this.createdAt,
      this.updatedAt,
      this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    phoneNumber = json['phone_number'];
    jobTitle = json['job_title'];
    userLevelId = json['user_level_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }
}

class Image {
  int? id;
  String? url;
  bool? isDeleted;

  Image({this.id, this.url, this.isDeleted});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    isDeleted = json['is_deleted'];
  }
}
