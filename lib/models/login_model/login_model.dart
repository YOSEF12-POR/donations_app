class LoginModel{
  bool?status;
  String?message;
  DataModel?data;

  LoginModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null? DataModel.fromJson(json['data']):null;
  }
}

class DataModel{

int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? token;


  DataModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    email = json['email'];

    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];

 
  }
}