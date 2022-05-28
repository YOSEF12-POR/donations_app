class CategoryModel {
  late bool status;
  late CategoryDataModel data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  late int currentPage;
  late List<DataModelCa> data = [];
  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModelCa.fromJson(element));
    });
  }
}

class DataModelCa {
  late int id;
  late String name;
  late String image;
//   late int id;
//  late String name;
//  late String imagePath;
//  late String createdAt;
//  late String updatedAt;


  DataModelCa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    // id = json['id'];
    // name = json['name'];
    // imagePath = json['image_path'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];

    
  }
}
