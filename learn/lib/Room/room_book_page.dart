import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

DatabaseReference bookingsRef =
    FirebaseDatabase.instance.ref().child("bookings");

class RoomBookPage extends StatefulWidget {
  final int id;
  final String username;
  const RoomBookPage(this.id, this.username);

  @override
  State<RoomBookPage> createState() => _RoomBookPageState();
}

class _RoomBookPageState extends State<RoomBookPage> {
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(Duration(days: 1));
  int noOfPeople = 1;
  var info = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Details")),
      body: Column(
        children: [
          ListTile(
            title: Text(
                "Check In Date: " + checkInDate.toString().substring(0, 11),
                style: TextStyle(fontSize: 20)),
            shape: Border(
              bottom: BorderSide(width: 0.2, color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 100,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: checkInDate,
              onDateTimeChanged: (DateTime newDateTime) {
                this.setState(() {
                  checkInDate = newDateTime;
                });
              },
            ),
          ),
          SizedBox(height: 50),
          ListTile(
            title: Text(
                "Check Out Date: " + checkOutDate.toString().substring(0, 11),
                style: TextStyle(fontSize: 20)),
            shape: Border(
              bottom: BorderSide(width: 0.2, color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 100,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                this.setState(() {
                  checkOutDate = newDateTime;
                });
              },
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                  child:
                      Text("Number of Guests", style: TextStyle(fontSize: 20))),
              SizedBox(width: 20),
              noOfPeople > 0
                  ? IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 40,
                      onPressed: () {
                        this.setState(() {
                          noOfPeople--;
                        });
                      },
                    )
                  : Container(),
              Text(noOfPeople.toString(), style: TextStyle(fontSize: 20)),
              IconButton(
                icon: Icon(Icons.add),
                iconSize: 40,
                onPressed: () {
                  this.setState(() {
                    noOfPeople++;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Text(info, style: TextStyle(fontSize: 18)),
          ElevatedButton(
            onPressed: () {
              bookingsRef
                  .child(this.widget.username.toString())
                  .push()
                  .set(this.widget.id);

              this.setState(() {
                info = "Room Booked!";
              });
            },
            child: Text("Book Now"),
          )
        ],
      ),
    );
  }
}
