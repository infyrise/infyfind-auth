class UserModel {
  final String? name;
  final String? email;
  final String? username;

  UserModel({this.name, this.email, this.username});

  factory UserModel.fromJson(Map json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      username: json["username"],
    );
  }
}