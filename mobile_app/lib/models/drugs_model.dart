class CreateCheckUpDrugs {
  int? id;
  int? quantity;
  int? timesPerDay;
  Checkup? checkup;
  Drug? drug;

  CreateCheckUpDrugs(
      {this.id, this.quantity, this.timesPerDay, this.checkup, this.drug});

  CreateCheckUpDrugs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    timesPerDay = json['times_per_day'];
    checkup =
        json['checkup'] != null ? new Checkup.fromJson(json['checkup']) : null;
    drug = json['drug'] != null ? new Drug.fromJson(json['drug']) : null;
  }
}

class Checkup {
  int? id;
  String? description;
  String? createdAt;
  String? updatedAt;
  Doctor? doctor;
  Doctor? patient;

  Checkup(
      {this.id,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.doctor,
      this.patient});

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

  Doctor(
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

class Drug {
  int? id;
  String? drugName;

  Drug({this.id, this.drugName});

  Drug.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drugName = json['drug_name'];
  }
}
