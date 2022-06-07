class ProjectsDetailsModel {
  late bool status;
  ProjectsDataModel ? data;

  ProjectsDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ProjectsDataModel.fromJson(json['data']) : null;
  }

}

class ProjectsDataModel {

  List<ProjectCategoryM> category = [];
  List<ProjectAssociationM> association = [];

  int? id;
  int? associationId;
  int? categoryId;
  int? priceStock;
  int? requireAmount;
  int? receivedAmount;
  String? durationUnit;
  int? interval;
  int? numBeneficiaries;
  int? currentNumBeneficiaries;
  String? status;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;
  

  ProjectsDataModel.fromJson(Map<String, dynamic> json) {
    json['category'].forEach((element) {
      category.add(ProjectCategoryM.fromJson(element));
    });

    json['association'].forEach((element) {
      association.add(ProjectAssociationM.fromJson(element));
    });

    id = json['id'];
    associationId = json['association_id'];
    categoryId = json['category_id'];
    priceStock = json['price_stock'];
    requireAmount = json['require_amount'];
    receivedAmount = json['received_amount'];
    durationUnit = json['duration_unit'];
    interval = json['interval'];
    numBeneficiaries = json['num_beneficiaries'];
    currentNumBeneficiaries = json['current_num_beneficiaries'];
    status = json['status'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];



  }
}

class ProjectCategoryM {
  int? id;
  String? name;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  ProjectCategoryM(
      {this.id, this.name, this.imagePath, this.createdAt, this.updatedAt});

  ProjectCategoryM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  }



  class ProjectAssociationM {
  int? id;
  String? name;
  String? address;
  String? email;

  ProjectAssociationM({this.id, this.name, this.address, this.email});

  ProjectAssociationM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
  }
  }

