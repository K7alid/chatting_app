class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String password;
  late String uId;
  late String image;
  late String coverImage;
  late String bio;
  bool isEmailVerified = false;

  SocialUserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    required this.uId,
    required this.image,
    required this.coverImage,
    required this.bio,
    required this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    uId = json['uId'];
    image = json['image'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'uId': uId,
      'bio': bio,
      'image': image,
      'coverImage': coverImage,
      'isEmailVerified': isEmailVerified,
    };
  }
}
