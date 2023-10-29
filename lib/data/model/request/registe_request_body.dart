class RegisteRequestBody {
  String? name;
  String? email;
  String? password;
  String? rePassword;
  String? phone;

  RegisteRequestBody(
      {this.name, this.email, this.password, this.rePassword, this.phone});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["password"] = password;
    map["rePassword"] = rePassword;
    map["phone"] = phone;
    return map;
  }
}
