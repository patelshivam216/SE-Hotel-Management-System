import 'package:flutter/material.dart';
import 'package:learn/User/user_login.dart';
import 'package:learn/Manager/manager_login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'Milestone Hotel',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => UserLogin()));
                  },
                  child: Text('User Login')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => UserLogin()));
                  },
                  child: Text('Employee Login')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => ManagerLogin()));
                  },
                  child: Text('Manager Login')),
            ],
          ),
        ));
  }
}
