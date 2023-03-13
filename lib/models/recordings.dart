import 'package:flutter/foundation.dart';

class Recordings {
  List<Record> list = [];

  void add(Record record) {
    try {
      list.add(record);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}

class Record {
  String path;

  Record(this.path);
}
