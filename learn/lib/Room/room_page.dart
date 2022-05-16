import 'package:flutter/material.dart';
import 'package:learn/Room/room.dart';
import 'package:learn/Room/room_book_page.dart';

class RoomPage extends StatelessWidget {
  Room room;
  final String username;
  RoomPage(this.room, this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext ctx) =>
                      RoomBookPage(room.id, this.username)));
        },
        label: Text("Add to Booking", style: TextStyle(fontSize: 20)),
      ),
      body: Container(
        child: ListView(children: [
          SizedBox(
              child: room.imageUrls.isNotEmpty
                  ? Image.network(room.imageUrls.first, fit: BoxFit.cover)
                  : Center(
                      child: Text("No Image Available",
                          style: TextStyle(fontSize: 15)),
                    ),
              height: 350,
              width: 600),
          ListTile(
            title: Text("Room #" + room.id.toString(),
                style: TextStyle(fontSize: 25)),
            tileColor: Colors.black12,
            shape: Border(
              bottom: BorderSide(width: 1, color: Colors.black54),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text(room.isAc ? "AC Room" : "Non-AC Room",
                      style: TextStyle(fontSize: 20)),
                ),
                Text(room.price.toString() + ' \u{20B9}',
                    style: TextStyle(fontSize: 20))
              ],
            ),
            tileColor: Colors.black12,
            shape: Border(
              bottom: BorderSide(width: 1, color: Colors.black54),
            ),
          ),
          ListTile(
            title: Text("Room Description", style: TextStyle(fontSize: 25)),
            tileColor: Colors.black12,
          ),
          ListTile(
            title: Text(room.description, style: TextStyle(fontSize: 18)),
            tileColor: Colors.black12,
          ),
        ]),
      ),
    );
  }
}
