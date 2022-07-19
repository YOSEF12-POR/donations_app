class ProfileModel {
  late bool status;
  ProfileDataModel? data;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
       data = ProfileDataModel.fromJson(json['data']);

  }
}

class ProfileDataModel {
  int? id;
  String? name;
  String? email;
    int? password;


  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
        password = json['password'];

  }
}
