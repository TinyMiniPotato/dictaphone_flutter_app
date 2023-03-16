// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dictaphone_app/providers/recordings.dart';
import 'package:dictaphone_app/utils/record.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:record/record.dart';
import 'package:dictaphone_app/conf.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RecordButton(),
      ],
    );
  }
}

class RecordButton extends StatelessWidget {
  final record = Record();

  RecordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => startRecording(context),
      icon: Icon(
        Provider.of<RecordingsProvider>(context).isRecording
            ? Icons.square
            : Icons.circle,
        color: Colors.red,
      ),
    );
  }

  Future<bool> startRecording(BuildContext context) async {
    if (await record.isRecording()) {
      Provider.of<RecordingsProvider>(context, listen: false)
          .changeRecordState();
      stopRecording();
      return true;
    }

    // Check and request permission
    if (await record.hasPermission()) {
      int numberRecordings =
          Provider.of<RecordingsProvider>(context, listen: false)
              .recordsList
              .length;
      // Start recording
      final String pathDir = await createFolderInAppDocDir(recordFile);
      Directory appFolder = Directory(pathDir);
      bool appFolderExists = await appFolder.exists();
      if (!appFolderExists) {
        final created = await appFolder.create(recursive: true);
        if (kDebugMode) {
          print(created.path);
        }
      }

      final filepath = '${appFolder.path}recording$numberRecordings.m4a';
      if (kDebugMode) {
        print(filepath);
      }

      Provider.of<RecordingsProvider>(context, listen: false)
          .changeRecordState();
      await record.start(
        path: filepath,
      );
      Provider.of<RecordingsProvider>(context, listen: false)
          .add(MyRecord(filepath));
    }
    return await record.isRecording();
  }

  Future<String?> stopRecording() async {
    String? path = await record.stop();
    if (kDebugMode) {
      print(path);
    }
    return path;
  }

  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory appDocDirFolder =
        Directory('${appDocDir.path}/$folderName/');

    if (await appDocDirFolder.exists()) {
      //if folder already exists return path
      return appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory appDocDirNewFolder =
          await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder.path;
    }
  }
}
