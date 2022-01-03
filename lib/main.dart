import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'User.dart';

void main() {
  runApp(MaterialApp(
    title: 'Api Integration Example',
    theme: ThemeData(primarySwatch: Colors.green),
    home: Scaffold(
      appBar: AppBar(title: Text('Api Integration Example')),
      body: MyHomePage(),
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var getUsersData, listUsers;

  Future<List<User>> fetchUsers() async {
    try {
      Response response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        var getUsersData = response.data as List;
        var listUsers = getUsersData.map((i) => User.fromJSON(i)).toList();
        return listUsers;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    listUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Example',
      home: Scaffold(
        body: FutureBuilder<List<User>>(
          future: listUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var user = (snapshot.data as List<User>)[index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(user.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22)),
                          SizedBox(height: 5),
                          Text(user.email),
                          SizedBox(height: 5),
                          Text(user.address.street +
                              ' ' +
                              user.address.suite +
                              ' ' +
                              user.address.city +
                              ' ' +
                              user.address.zipcode),
                          SizedBox(height: 5),
                          Text(user.phone),
                          SizedBox(height: 5),
                          Text(user.website),
                          SizedBox(height: 5),
                          Text(user.company.name),
                          SizedBox(height: 5),
                          Text(user.company.catchPhrase),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: (snapshot.data as List<User>).length);
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return Center(
              child:
                  CircularProgressIndicator(backgroundColor: Colors.cyanAccent),
            );
          },
        ),
      ),
    );
  }
}
