class UserModel {
  String? sId;
  String? name;
  String? email;
  String? mobile;
  String? imgURL;
  String? date;
  String? password;

  UserModel({
    this.sId,
    this.name,
    this.email,
    this.mobile,
    this.imgURL,
    this.date,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    mobile = json['mobile'] ?? '';
    imgURL = json['imgURL'] ?? '';
    date = json['date'] ?? '';
    password = json['password'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user['_id'] = sId;
    user['name'] = name;
    user['email'] = email;
    user['mobile'] = mobile;
    user['imgURL'] = imgURL;
    user['date'] = date;
    user['password'] = password;
    return user;
  }
}
