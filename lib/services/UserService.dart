import 'package:http/http.dart' as http;
import 'dart:convert';

Future getUsers() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/users');
  final users = json.decode(response.body);
  return users;
}
