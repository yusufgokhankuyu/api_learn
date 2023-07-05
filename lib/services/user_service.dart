import 'dart:convert';
import 'package:flutter_api/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String url = "https://reqres.in/api/users?page=2";

  Future<UserModel?> fetchUsers() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var jsonBody = UserModel.fromJson(jsonDecode(res.body));
      return jsonBody;
    } else {
      print("Başarısız => ${res.statusCode}");
    }
  }
}
