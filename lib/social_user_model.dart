class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String password;
  late String uId;
  late bool isEmailVerified;

  SocialUserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'uId': uId,
    };
  }
}
