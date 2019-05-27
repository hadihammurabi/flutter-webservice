import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webservice/bloc/UserBloc.dart';
import 'package:webservice/services/UserService.dart' as userService;

class User extends StatefulWidget {
  User({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {

    final UserBloc userBloc = Provider.of<UserBloc>(context);

    userService.getUsers().then((u) {
      setState(() {
        userBloc.users = u;
      });
    });

    var body;
    if (userBloc.users == null) {
      body = Center(child: Text('Data kosong'));
    } else {
      body = Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 10.0,
              child: ListView.builder(
                itemCount: userBloc.users.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Card(
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userBloc.users[index]['username'],
                              style: TextStyle(fontSize: 15.0),
                            ),
                            Text(
                              userBloc.users[index]['name'],
                              style: TextStyle(fontSize: 25.0),
                            ),
                            Text(
                              userBloc.users[index]['email'],
                              style: TextStyle(fontSize: 15.0),
                            ),
                            Text(
                              userBloc.users[index]['phone'],
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
