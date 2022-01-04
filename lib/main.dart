import 'package:dio/dio.dart';
import 'package:dio_apieg/Address.dart';
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
  // const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var getUsersData;
  var listUsers;

  List<String> data = [];

  fetchUsers() async {
    try {
      Response response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        getUsersData = response.data as List;

        /*getUsersData.forEach((el) {
          List<Address> sublist =
              el["address"].map((val) => User.fromJSON(val)).toList();
          //data.add(User(sublist));
        }); */
        listUsers = getUsersData.map((i) => User.fromJSON(i)).toList();
        print(listUsers);
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
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Example',
      home: Scaffold(
        body: FutureBuilder(
          future: fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var user = (snapshot.data as List)[index];
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
                          Text(user.address.geo.lat +
                              ' ' +
                              user.address.geo.lng),
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
                  itemCount: (snapshot.data as List).length);
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return Center(
              child: const CircularProgressIndicator(
                  backgroundColor: Colors.cyanAccent),
            );
          },
        ),
      ),
    );
  }
}
