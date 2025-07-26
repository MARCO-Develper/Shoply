import 'dart:convert';

class UpdateUserRequest {
  String? name;
  String? password;

  UpdateUserRequest({this.name, this.password});

  String toJson() {
    final Map<String, dynamic> data = {};

    if (name != null && name!.isNotEmpty) {
      data['name'] = name;
    }
    if (password != null && password!.isNotEmpty) {
      data['password'] = password;
    }

    return jsonEncode(data);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};

    if (name != null && name!.isNotEmpty) {
      data['name'] = name;
    }
    if (password != null && password!.isNotEmpty) {
      data['password'] = password;
    }

    return data;
  }
}
