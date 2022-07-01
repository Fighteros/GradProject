class AnalysisModel {
  int? id;
  int? checkupId;
  int? analysisId;
  Image? image;
  Checkup? checkup;
  Analysis? analysis;

  AnalysisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkupId = json['checkup_id'];
    analysisId = json['analysis_id'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    checkup =
        json['checkup'] != null ? new Checkup.fromJson(json['checkup']) : null;
    analysis = json['analysis'] != null
        ? new Analysis.fromJson(json['analysis'])
        : null;
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

class Checkup {
  int? id;
  String? description;
  String? createdAt;
  String? updatedAt;
  Doctor? doctor;
  Doctor? patient;

  Checkup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    patient =
        json['patient'] != null ? new Doctor.fromJson(json['patient']) : null;
  }
}

class Doctor {
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

  Doctor.fromJson(Map<String, dynamic> json) {
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

class Analysis {
  int? id;
  String? name;
  Analysis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
