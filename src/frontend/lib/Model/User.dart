class User{
  String id;
  String name;
  String role;
  String email;
  String password;
  
  User({this.name, this.role, this.email, this.id, this.password});

  User.fromJson(Map<String, dynamic> json) {
      id = json["id"].toString();
      name = json["name"];
      role = json["role"].toString();
      email = json["email"].toString();
      password = json["password"].toString();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "email": email,
    "password": password
  };
}