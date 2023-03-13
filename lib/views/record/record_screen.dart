import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:record/record.dart';

class RecordScreen extends StatelessWidget {
  final record = Record();

  RecordScreen({super.key});

  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  Future<bool> startRecording() async {
    if (await record.isRecording()) {
      stopRecording();
      return true;
    }

    // Check and request permission
    if (await record.hasPermission()) {
      // Start recording
      final String pathDir = await createFolderInAppDocDir('test');
      Directory appFolder = Directory(pathDir);
      bool appFolderExists = await appFolder.exists();
      if (!appFolderExists) {
        final created = await appFolder.create(recursive: true);
        print(created.path);
      }
      final filepath = '${appFolder.path}bla.m4a';
      print(filepath);

      await record.start(
        path: filepath,
        encoder: AudioEncoder.aacLc, // by default
      );
    }
    return await record.isRecording();
  }

  Future<void> stopRecording() async {
    String? path = await record.stop();
    print(path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RecordButton(onPressed: startRecording),
      ],
    );
  }
}

class RecordButton extends StatelessWidget {
  final void Function()? onPressed;

  const RecordButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Record'),
    );
  }
}
