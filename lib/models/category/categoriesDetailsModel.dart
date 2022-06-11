class CategoryDetailModel {
  bool? status;
  late Data data;

  CategoryDetailModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    status = json['status'];
  }
}

class Data {
  late List<Projects>? projects;

  Data.fromJson(Map<String, dynamic> json) {
    projects = [];
    json['data'].forEach((element) {
      projects!.add(Projects.fromJson(element));
    });
  }
}

class Projects {
  int? id;
  dynamic? categoryId;
  String? description;
  String? title;
dynamic? require_amount;
   dynamic?   received_amount;
   
  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    description = json['description'];
    title = json['title'];
      require_amount = json['require_amount'];
    received_amount = json['received_amount'];
  }
}
