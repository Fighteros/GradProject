class DrugsModel {
  int? id;
  String? drugName;

  DrugsModel({this.id, this.drugName});

  DrugsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drugName = json['drug_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['drug_name'] = this.drugName;
    return data;
  }
}
