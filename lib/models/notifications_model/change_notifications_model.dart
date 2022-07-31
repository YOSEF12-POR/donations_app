class  ChangeNotificationsModel{
   bool? status;
  String? message;
  ChangeNotificationsModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    
    }
}