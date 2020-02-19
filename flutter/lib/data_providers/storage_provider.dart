import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageProvider {
  final _storage = FirebaseStorage().ref();

  Future<String> uploadPostImage({
    @required File imageFile,
    @required String documentId,
    @required String uid,
  }) async {
    final ref = _storage.child('posts/$uid/$documentId/post');
    final task = ref.putFile(imageFile);
    await task.onComplete;
    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl.toString();
  }
}
