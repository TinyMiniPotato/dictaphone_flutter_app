import 'dart:io';

import 'package:dictaphone_app/conf.dart';
import 'package:dictaphone_app/utils/record.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class RecordingsProvider extends ChangeNotifier {
  bool isRecording = false;

  void changeRecordState() {
    isRecording = !isRecording;
    notifyListeners();
  }

  List<MyRecord> recordsList = [];
  MyRecord? playingRecord;

  void get() async {
    List<FileSystemEntity> folders;
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory appDocDirFolder =
        Directory('${appDocDir.path}/$recordFile/');

    folders = appDocDirFolder.listSync(recursive: true, followLinks: false);
    if (kDebugMode) {
      print(folders.length);
    }

    recordsList = [];
    for (var f in folders) {
      recordsList.add(MyRecord(f.path));
    }
    notifyListeners();
  }

  void add(MyRecord record) {
    try {
      recordsList.add(record);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  void remove(MyRecord record) {
    try {
      recordsList.remove(record);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
