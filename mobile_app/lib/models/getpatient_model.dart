class GetPatientModel {
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
  Images? image;

  GetPatientModel(
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
  // List<dynamic> names = [];
  GetPatientModel.fromJson(Map<String, dynamic> json) {
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
    image = json['image'] != null ? new Images.fromJson(json['image']) : null;
    // json['first_name'].forEach((e) {
    //   names.add(e);
    // });
  }
}

class Images {
  int? id;
  String? url;
  bool? isDeleted;

  Images({this.id, this.url, this.isDeleted});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    isDeleted = json['is_deleted'];
  }
}
