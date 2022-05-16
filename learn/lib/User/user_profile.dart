import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

DatabaseReference bookingsRef =
    FirebaseDatabase.instance.ref().child("bookings");

class UserProfile extends StatefulWidget {
  UserProfile(this.username, this.bookedRooms);
  final String username;
  List<String> bookedRooms;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.people),
            Text("   Profile: "),
            Text(this.widget.username)
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              "Booked Rooms ",
              style: TextStyle(fontSize: 25),
            ),
            tileColor: Colors.blue.shade300,
            shape: Border(
              bottom: BorderSide(width: 0.2, color: Colors.black54),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: this.widget.bookedRooms.length,
                itemBuilder: (context, index) {
                  String roomId = this.widget.bookedRooms[index];
                  return ListTile(
                    title: Text("Room #" + roomId),
                    tileColor: Colors.blue.shade300,
                    shape: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.black54),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
