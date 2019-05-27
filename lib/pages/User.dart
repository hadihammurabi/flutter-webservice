import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
  User({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List<dynamic> users;

  Future getUsers() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/users');
    final users = json.decode(response.body);
    return users;
  }

  @override
  void initState() {
    super.initState();

    getUsers().then((u) {
      print(u.length);
      setState(() {
        users = u;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var body;
    if (users == null) {
      body = Text('Data kosong');
    } else {
      body = Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 10.0,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Card(
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              users[index]['username'],
                              style: TextStyle(fontSize: 15.0),
                            ),
                            Text(
                              users[index]['name'],
                              style: TextStyle(fontSize: 25.0),
                            ),
                            Text(
                              users[index]['email'],
                              style: TextStyle(fontSize: 15.0),
                            ),
                            Text(
                              users[index]['phone'],
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body,
    );
  }
}
