import 'package:flutter/material.dart';

import 'package:record/record.dart';

class RecordScreen extends StatelessWidget {
  final record = Record();

  RecordScreen({super.key});

  Future<bool> startRecording() async {
    if (await record.isRecording()) {
      stopRecording();
      return true;
    }

    // Check and request permission
    if (await record.hasPermission()) {
      // Start recording
      await record.start(
        path: 'test/myFile.m4a',
        encoder: AudioEncoder.aacLc, // by default
      );
    }
    return await record.isRecording();
  }

  Future<void> stopRecording() async {
    await record.stop();
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
