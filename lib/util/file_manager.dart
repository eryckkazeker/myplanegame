import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<String> _localPath() async {
    try {
      var directory = await getExternalStorageDirectory();
      return directory.path;
    } catch (Exception) {
      debugPrint('Error getting external directory. Trying fallback option');
      var fallbackDirectory = await getApplicationDocumentsDirectory();
      return fallbackDirectory.path;
    }
    
  }

  static Future<File> _getSaveDataFile() async {
    var path = await _localPath();
    debugPrint('File path is [$path]');
    return File('$path/savegame.json');
  }

  static Future<File> saveDataToFile(String data) async {
    var saveFile = await _getSaveDataFile();
    return saveFile.writeAsString(data);
  }

  static Future<bool> saveFileExists() async {
    var saveFile = await _getSaveDataFile();
    return saveFile.exists();
  }

  static Future<String> readSaveFile() async {
    var file = await _getSaveDataFile();
    if(!await file.exists()) {
      return '';
    }

    return await file.readAsString();
  }

  static Future<void> deleteSaveFile() async {
    var file = await _getSaveDataFile();
    file.delete();
  }
}