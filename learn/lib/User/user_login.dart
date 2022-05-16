import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'user_home.dart';
import 'user_createAccount.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  var info = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Login'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: userNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'username',
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passWordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'password',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(info),
          ),
          //Login Button
          Center(
            child: ElevatedButton(
              onPressed: () async {
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                DatabaseReference usersRef =
                    FirebaseDatabase.instance.ref().child("users");
                var enteredUserName = userNameController.text;
                var userSnap = await FirebaseDatabase.instance
                    .ref()
                    .child("users/$enteredUserName")
                    .get();

                var storedPassWord = userSnap.value
                    .toString(); //username not exists if this is null
                if (storedPassWord == null) {
                  setState(() {
                    info = 'username does not exists';
                  });
                } else {
                  var enteredPassword = passWordController.text;
                  if (enteredPassword == storedPassWord) {
                    //goto home
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) =>
                                UserHome(enteredUserName)));
                  } else {
                    setState(() {
                      info = 'wrong Password';
                    });
                  }
                }
              },
              child: const Text('Login'),
            ),
          ),

          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => UserCreateAccount()));
              },
              child: const Text('Create Account')),
        ],
      ),
    );
  }
}
