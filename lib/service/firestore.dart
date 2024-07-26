import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
class FirebaseStorageService{
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadFile(File file, String folder)
 async {
  try{
    String fileName = path.basename(file.path);
    Reference ref = _storage.ref().child('$folder/$fileName');
    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete((() => {}));
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    debugPrint('Error uploading file: $e');
    return null;
  }
  }


  Future<File?> downloadFile(String downloadUrl, String localPath) async {
    try{
      final ref = _storage.refFromURL(downloadUrl);
      final File file = File(localPath);
      await ref.writeToFile(file);
      return file;
    } catch (e) {
      debugPrint('Error downloading file: $e');
      return null;
    }
  }

  Future<bool>deleteFile(String downloadURL) async {
    try{
      final ref = _storage.refFromURL(downloadURL);
      await ref.delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting file: $e');
      return false;
    }
  }
  Future<List<String>> listFiles(String folder) async {
    try{
      final ListResult result = await _storage.ref(folder).listAll();
      List<String> fileUrls = [];
      for (var item in result.items){
        String downloadURL = await item.getDownloadURL ();
        fileUrls.add(downloadURL);
      }
      return fileUrls;
    } catch (e) {
      debugPrint('Error listing files: $e');
      return [];
    }
  }
  Future<Map<String, dynamic>?> getFileMetadata(String downloadURL) async{
    try{
      final ref = _storage.refFromURL(downloadURL);
      final FullMetadata metadata = await ref.getMetadata();
      return {
        'name': metadata.name,
        'size': metadata.size,
        'contentType' : metadata.contentType,
        'timeCreated' : metadata.timeCreated,
        'updated' : metadata.updated,
        'customMeta' : metadata.customMetadata,
      };
    } catch(e){
      debugPrint("Error getting file metadata: $e");
      return null;
    }
  }

  Future<bool> updateFileMetadata(
      String downloadURl, Map<String, String> newMetadata) async {
    try{
      final ref = _storage.refFromURL(downloadURl);
      await ref.updateMetadata(SettableMetadata(customMetadata: newMetadata));
      return true;
    } catch (e) {
      debugPrint('Error updating file metadata: $e');
      return false;
    }
  }
}