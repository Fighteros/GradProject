class DrugsModel {
  int? id;
  String? drugName;

  DrugsModel({this.id, this.drugName});

  DrugsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drugName = json['drug_name'];
  }
}
