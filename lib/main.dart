// ignore_for_file: prefer_const_constructors

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Color primaryColour = Colors.amber;

  void changeThemeColour(color) {
    setState(() {
      primaryColour = color;
    });
    debugPrint(primaryColour.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: "TODO App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColour,
        // textTheme: primaryColour.computeLuminance() > 0.5
        //     ? Typography.blackRedmond
        //     : Typography.whiteRedmond
        // textTheme: GoogleFonts.margarineTextTheme()),
      ),
      home: HomePage(changeThemeColourFunc: changeThemeColour),
    );
  }
}
