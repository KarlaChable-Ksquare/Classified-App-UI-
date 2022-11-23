class AdsModel {
  String? sId;
  String? title;
  String? description;
  num? price;
  List<String>? images;
  String? authorName;
  String? userId;
  String? mobile;
  String? createdAt;

  AdsModel(
      {this.sId,
      this.title,
      this.description,
      this.price,
      this.images,
      this.authorName,
      this.userId,
      this.mobile,
      this.createdAt});

  AdsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    title = json['title'] ?? 'title';
    description = json['description'] ?? 'description';
    price = json['price'] ?? '0';
    images = List<String>.from(
        json['images'] ?? ["https://i.ibb.co/wN7ZCYb/gweenpool.jpg"]);
    authorName = json['authorName'] ?? '';
    userId = json['userId'] ?? '';
    mobile = json['mobile'] ?? '9999012345';
    createdAt = json['createdAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
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
