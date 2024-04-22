class User {
  int id;
  String name;
  String email;
  String password;
  String token;
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.token});
  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
        password: json['user']['password'],
        token: json['jwtToken']);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "token": token,
    };
  }
}
