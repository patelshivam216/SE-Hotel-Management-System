import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learn/Room/room.dart';

class RoomList extends StatefulWidget {
  final List<Room> rooms;
  RoomList(this.rooms);

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
              child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Room #" + room.id.toString(),
                          style: TextStyle(fontSize: 25)),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(room.isAc ? "AC" : "Non-AC",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                room.imageUrls.isNotEmpty
                    ? SizedBox(
                        child: Image.network(room.imageUrls.first,
                            fit: BoxFit.none),
                        height: 200,
                        width: 500)
                    : Text("No Image Available",
                        style: TextStyle(fontSize: 15)),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child:
                        Text(room.description, style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
