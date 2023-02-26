class UserModel {
  String name;
  String email;
  String uid;

  UserModel({required this.name, required this.email, required this.uid});

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        uid = json['uid'];
}
