class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProjectsModel> Projects = [];
 

int? count_project = 0; 
int? sum_received_amount = 0;
int? sum_num_beneficiaries = 0;



  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      Projects.add(ProjectsModel.fromJson(element));
    });


    count_project = json['count_project'];
    sum_received_amount = json['sum_received_amount'];
    sum_num_beneficiaries = json['sum_num_beneficiaries'];

  }
}




class BannerModel {
  int? id;
  String? name;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class ProjectsModel {
  int? id;
  int? categoryId;
  String? description;
  String? title;
    dynamic? require_amount;
  dynamic? received_amount;
    String? image_path;



  ProjectsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    description = json['description'];
    title = json['title'];
        image_path = json['image_path'];

    require_amount = json['require_amount'];
    received_amount = json['received_amount'];
  }
}
