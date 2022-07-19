class ProjectCompModel {
  late bool status;
  late ProjectCompDataModel data;

  ProjectCompModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ProjectCompDataModel.fromJson(json['data']);
  }
}

class ProjectCompDataModel {
  List<ProjectsCModel> projectc = [];
  List<ProjectsPModel> projectp = [];



  ProjectCompDataModel.fromJson(Map<String, dynamic> json) {
    json['projects_completed'].forEach((element) {
      projectc.add(ProjectsCModel.fromJson(element));
    });

    json['projects_completed_partial'].forEach((element) {
      projectp.add(ProjectsPModel.fromJson(element));
    });


  }
}

class ProjectsCModel {

  int? id;
  int? categoryId;
  String? description;
  String? title;
  dynamic? require_amount;
  dynamic? received_amount;
  String? image_path;

  ProjectsCModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    description = json['description'];
    title = json['title'];
    image_path = json['image_path'];
    require_amount = json['require_amount'];
    received_amount = json['received_amount'];
  }
}

class ProjectsPModel {
  int? id;
  int? categoryId;
  String? description;
  String? title;
  dynamic? require_amount;
  dynamic? received_amount;
  String? image_path;

  ProjectsPModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    description = json['description'];
    title = json['title'];
    image_path = json['image_path'];
    require_amount = json['require_amount'];
    received_amount = json['received_amount'];
  }
}
