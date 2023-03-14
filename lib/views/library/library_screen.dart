import 'dart:io';

import 'package:dictaphone_app/providers/recordings.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Record> list = Provider.of<RecordingsProvider>(context).recordsList
      ..sort((a, b) => a.path.compareTo(b.path));
    if (list.isEmpty) {
      Provider.of<RecordingsProvider>(context).get();
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int i) {
          return RecordingButton(
            index: i,
          );
        },
      ),
    );
  }
}

class RecordingButton extends StatelessWidget {
  final int index;

  const RecordingButton({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final String path =
        Provider.of<RecordingsProvider>(context).recordsList[index].path;
    final String name = path.substring(path.lastIndexOf('/') + 1, path.length);

    return InkWell(
      child: Row(
        children: [Icon(Icons.play_arrow), Text(name)],
      ),
    );
  }
}
