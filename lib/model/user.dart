// ignore_for_file: unnecessary_this

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
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    imgURL = json['imgURL'];
    date = json['date'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user['_id'] = this.sId;
    user['name'] = this.name;
    user['email'] = this.email;
    user['mobile'] = this.mobile;
    user['imgURL'] = this.imgURL;
    user['date'] = this.date;
    user['password'] = this.password;
    return user;
  }
}
