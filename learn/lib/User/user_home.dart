import 'package:flutter/material.dart';
import 'package:learn/Room/room_list.dart';
import 'package:learn/Room/room.dart';
import 'package:learn/User/user_profile.dart';
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

Future<List<String>> getBookedRooms(String username) async {
  List<String> bookedRooms = [];
  DataSnapshot bookingsSnap = await FirebaseDatabase.instance
      .ref()
      .child("bookings")
      .child(username)
      .get();
  for (DataSnapshot idSnap in bookingsSnap.children) {
    bookedRooms.add((idSnap.value as int).toString());
  }
  return bookedRooms;
}

class UserHome extends StatefulWidget {
  UserHome(this.username);
  final String username;
  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<Room> roomList = [];
  List<String> bookedRooms = [];

  void updateRoomsList() {
    getRoomList().then((newRoomsList) => {
          this.setState(() {
            this.roomList = newRoomsList;
          })
        });
  }

  void updateBookedRooms() {
    getBookedRooms(this.widget.username).then((newBookedRooms) => {
          this.setState(() {
            this.bookedRooms = newBookedRooms;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateRoomsList();
    updateBookedRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Room List'),
        actions: [
          TextButton(
            onPressed: () async {
              updateBookedRooms();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) =>
                          UserProfile(this.widget.username, bookedRooms)));
            },
            child: Text("Profile"),
          ),
          TextButton(
            onPressed: () {
              updateRoomsList();
              updateBookedRooms();
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
      body: RoomList(roomList, this.widget.username),
      backgroundColor: Colors.blue.shade100,
    );
  }
}
