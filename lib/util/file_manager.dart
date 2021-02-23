import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<String> _localPath() async {
    var directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _getSaveDataFile() async {
    var path = await _localPath();
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
}