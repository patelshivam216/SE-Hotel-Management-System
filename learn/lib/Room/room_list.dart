import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learn/Room/room.dart';
import 'package:learn/Room/room_page.dart';

class RoomList extends StatefulWidget {
  final List<Room> rooms;
  RoomList(this.rooms, this.username);
  final String username;
  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.widget.rooms.length,
        itemBuilder: (context, index) {
          var room = this.widget.rooms[index];
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(width: 1, color: Colors.black87)),
              borderOnForeground: true,
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx) =>
                              RoomPage(room, this.widget.username)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black54, width: 0.5))),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Room #" + room.id.toString(),
                                  style: TextStyle(fontSize: 25)),
                            )),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(room.price.toString() + ' \u{20B9}',
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(room.isAc ? "AC" : "Non-AC",
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          child: room.imageUrls.isNotEmpty
                              ? Image.network(room.imageUrls.first,
                                  fit: BoxFit.none)
                              : Center(
                                  child: Text("No Image Available",
                                      style: TextStyle(fontSize: 15)),
                                ),
                          height: 200,
                          width: 500),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                              room.description.length > 100
                                  ? room.description.substring(0, 90) + "..."
                                  : room.description,
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
