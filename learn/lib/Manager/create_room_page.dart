import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:learn/Room/room.dart';
import 'package:learn/User/user_home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:learn/firebase_api.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({Key? key}) : super(key: key);

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final IdController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  bool? isAC = false;
  String info = '';
  List<PlatformFile> files = [];
  DatabaseReference roomsRef = FirebaseDatabase.instance.ref().child("rooms");

  @override
  Widget build(BuildContext context) {
    if (files.isNotEmpty) print(files[0].path);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: IdController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Room Id',
            ),
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Room Description',
            ),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Room Price',
            ),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Expanded(
                child: Text("    AC Room"),
              ),
              Checkbox(
                value: isAC,
                onChanged: (bool? value) {
                  setState(() {
                    isAC = value;
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    //todo
                    selectFiles();
                  },
                  child: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), padding: EdgeInsets.all(10.0)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Add Images"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(info),
          ),
          ElevatedButton(
            onPressed: () async {
              if (IdController.text == '') {
                setState(() {
                  info = 'Please Enter Room ID';
                });
              } else {
                setState(() {
                  info = 'Creating Room Entry Please wait.';
                });
                Room room = Room(
                    int.parse(IdController.text),
                    descController.text,
                    int.parse(priceController.text),
                    this.isAC!);
                List<String> urls =
                    await uploadImagesForRoom(int.parse(IdController.text));
                room.setImageUrls(urls);
                saveRoom(room); //upload room to firebase

                setState(() {
                  info = 'Room Entry Created Succesfully';
                });
              }
            },
            child: Text('Create Room'),
          ),
        ],
      ),
    );
  }

  void saveRoom(Room r) {
    Map<dynamic, dynamic> room = r.toMap();
    roomsRef.child(r.id.toString()).set(room);
  }

  Future selectFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final paths = result.files;

    setState(() {
      files = paths;
    });
  }

  Future<List<String>> uploadImagesForRoom(int id) async {
    if (files.isEmpty) return [];
    List<String> urlList = [];
    for (var file in files) {
      var filename = basename(file.path!);
      var destination = 'files/$id/$filename';
      final task = FirebaseApi.uploadFile(destination, file);
      if (task == null) return [];
      final snapshot = await task.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      urlList.add(url);
    }
    return urlList;
  }
}
