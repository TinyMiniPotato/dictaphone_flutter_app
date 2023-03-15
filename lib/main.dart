import 'package:dictaphone_app/providers/audio_player.dart';
import 'package:dictaphone_app/providers/recordings.dart';
import 'package:dictaphone_app/views/library/library_screen.dart';
import 'package:dictaphone_app/views/record/record_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RecordingsProvider>(
          create: (_) => RecordingsProvider(),
        ),
        ChangeNotifierProvider<AudioPlayerController>(
          create: (_) => AudioPlayerController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LibraryScreen(),
      ),
    );
  }
}
