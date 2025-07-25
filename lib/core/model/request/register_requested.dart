class RegisterRequest {
  String? name;
  String? email;
  String? password;
  String? avatar;

  RegisterRequest({this.name, this.email, this.password, this.avatar});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['avatar'] = this.avatar ?? "https://picsum.photos/800";
    return data;
  }
}
