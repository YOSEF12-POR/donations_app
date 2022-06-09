class SearchModel {
  bool?status;
  Null?message;
  SearchData?data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  SearchData.fromJson(json['data']) : null;
  }
}

class SearchData {
  List<ProjectS> data=[];

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(ProjectS.fromJson(v));
      });
    }

  }
}


class ProjectS {
  int?id;
  dynamic association_id;
  String?title;
  String?description;

  ProjectS.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    association_id = json['association_id'];
    title = json['title'];
    description = json['description'];
  }

}