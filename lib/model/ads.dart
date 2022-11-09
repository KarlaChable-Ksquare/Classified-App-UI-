class AdsModel {
  //String? id;
  String? title;
  String? description;
  int? price;
  List<dynamic>? images;
  String? authorName;
  String? userId;
  String? mobile;
  String? createdAt;

  AdsModel(
      {
      //this.id,
      this.title,
      this.description,
      this.price,
      this.images,
      this.authorName,
      this.userId,
      this.mobile,
      this.createdAt});

  AdsModel.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    images = json['images'];
    authorName = json['authorName'];
    userId = json['userId'];
    mobile = json['mobile'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    //data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['images'] = this.images;
    data['authorName'] = this.authorName;
    data['userId'] = this.userId;
    data['mobile'] = this.mobile;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
