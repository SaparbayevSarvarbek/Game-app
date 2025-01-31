class UsernameModel {
  String username;
  String email;
  String password;
  String password2;

  UsernameModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.password2});

  factory UsernameModel.fromJson(Map<String, dynamic> json) {
    return UsernameModel(
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        password2: json['password2'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'password2': password2
    };
  }
}
