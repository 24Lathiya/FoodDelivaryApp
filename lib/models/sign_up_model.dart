class SignUp {
  String? name;
  String? mobile;
  String? email;
  String? password;

  SignUp({
    required this.name,
    required this.mobile,
    required this.email,
    required this.password,
  });

  SignUp.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();
    json['name'] = name;
    json['mobile'] = mobile;
    json['email'] = email;
    json['password'] = password;
    return json;
  }
}
