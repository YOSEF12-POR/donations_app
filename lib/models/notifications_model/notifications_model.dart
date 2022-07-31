class NotificationsDetailModel {
  bool? status;
  late Data data;

  NotificationsDetailModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    status = json['status'];
  }
}

class Data {
  late List<Notifications>? notification;

  Data.fromJson(Map<String, dynamic> json) {
    notification = [];
    json['data'].forEach((element) {
      notification!.add(Notifications.fromJson(element));
    });
  }
}

class Notifications {
  int? id;
  dynamic? user_id;
  dynamic? project_id;
  String? title;
  String? body;
  dynamic? is_read;

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    project_id = json['project_id'];
    title = json['title'];
    body = json['body'];
    is_read = json['is_read'];
  }
}
