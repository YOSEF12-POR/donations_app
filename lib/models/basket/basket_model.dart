class BasketModel {
  bool? status;
  late Data data;

  BasketModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    status = json['status'];
  }
}

class Data {
  late List<BasketsData>? baskets;
    int? count_basket;

  Data.fromJson(Map<String, dynamic> json) {
    baskets = [];
    json['basket'].forEach((element) {
      baskets!.add(BasketsData.fromJson(element));
    });

    count_basket = json['count_basket'];

  }


}

class BasketsData {
  int? id;
  dynamic? amount;
  String? title;
  String? image_path;
    String? category_name;


  BasketsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    title = json['title'];
    image_path = json['image_path'];
    category_name = json['category_name'];
  }
}
