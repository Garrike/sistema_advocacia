class User {
  final String email, name, userid, office, password;

  User({this.email, this.name, this.office, this.password, this.userid});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      userid: json['userid'],
      name: json['name'],
      office: json['office'],
      password: json['password']
    );
  }
}
