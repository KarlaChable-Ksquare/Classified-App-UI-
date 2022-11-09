class AdsModel {
  String? id;
  String? title;
  String? description;
  int? price;
  List<String>? images;
  String? authorName;
  String? userId;
  String? mobile;
  String? createdAt;

  AdsModel(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.images,
      this.authorName,
      this.userId,
      this.mobile,
      this.createdAt});

  AdsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    price = json['price'] ?? '';
    images = List<String>.from(
        json['images'] ?? ["https://i.ibb.co/wN7ZCYb/gweenpool.jpg"]);
    authorName = json['authorName'] ?? '';
    userId = json['userId'] ?? '';
    mobile = json['mobile'] ?? '';
    createdAt = json['createdAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['images'] = images;
    data['authorName'] = authorName;
    data['userId'] = userId;
    data['mobile'] = mobile;
    data['createdAt'] = createdAt;
    return data;
  }
}
