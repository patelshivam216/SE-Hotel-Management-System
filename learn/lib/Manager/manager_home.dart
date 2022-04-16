import 'package:flutter/material.dart';
import 'package:learn/Manager/create_room_page.dart';
import 'manager_login.dart';

class ManagerHome extends StatelessWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Manager Home'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => ManagerLogin()));
            },
            child: const Text('Logout'),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => CreateRoomPage()));
              },
              child: Text('Create Room'),
            ),
          ],
        ),
      ),
    );
  }
}
