class User {
  final String email, name, userid, office, password;
  final List processes, pending;

  User({this.email, this.name, this.office, this.password, this.userid, this.processes, this.pending});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      userid: json['userid'],
      name: json['name'],
      office: json['office'],
      password: json['password'],
      processes: json['processes'],
      pending: json['pending']
    );
  }
}
