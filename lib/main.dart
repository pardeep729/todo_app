// ignore_for_file: prefer_const_constructors

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'pages/homepage.dart';

void main() async {
  // init the hive
  // WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.initFlutter();

  // open a hive box
  var box = await Hive.openBox('myBox');

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: "TODO App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        // textTheme: GoogleFonts.margarineTextTheme()),
      ),
      home: HomePage(),
    );
  }
}
