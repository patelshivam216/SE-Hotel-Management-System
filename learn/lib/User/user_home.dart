import 'package:flutter/material.dart';
import 'package:learn/Room/room_list.dart';
import 'package:learn/Room/room.dart';
import 'user_login.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List<Room>> getRoomList() async {
  //tobe implemented
  DataSnapshot roomsSnap =
      await FirebaseDatabase.instance.ref().child("rooms").get();
  List<Room> roomList = [];
  for (DataSnapshot roomsnap in roomsSnap.children) {
    Map<dynamic, dynamic> roomMap = roomsnap.value as Map<dynamic, dynamic>;
    Room r = Room(0, "error", -1, true);
    r.setFromMap(roomMap);

    roomList.add(r);
  }
  return roomList;
}

class UserHome extends StatefulWidget {
  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<Room> roomList = [];

  void updateRoomsList() {
    getRoomList().then((newRoomsList) => {
          this.setState(() {
            this.roomList = newRoomsList;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateRoomsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Room List'),
        actions: [
          TextButton(
            onPressed: () {
              updateRoomsList();
            },
            child: Icon(Icons.refresh),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => UserLogin()));
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: RoomList(roomList),
    );
  }
}
