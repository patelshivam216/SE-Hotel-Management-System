import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String destination, PlatformFile file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(File(file.path!));
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
