import 'dart:io';

import 'package:databaseflutter/data/data.dart';
import 'package:databaseflutter/data/data.g.dart';
import 'package:databaseflutter/data/repo/repository.dart';
import 'package:databaseflutter/data/source/hive_task_source.dart';
import 'package:databaseflutter/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

const taskBoxName = 'tasks';

const Color primaryColor = Color(0xff794CFF);
const Color primaryVariantColor = Color(0xff5C0AFF);
const Color secondaryTextColor = Color(0xffAFBED0);
const Color highPriority = primaryColor;
const Color mediumPriority = Color(0xfff09819);
const Color lowPriority = Color(0xff3BE1F1);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskEntity>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: primaryVariantColor));
  print('...HERE...');
  runApp(ChangeNotifierProvider<Repository<TaskEntity>>(
      create: (context) =>
          Repository<TaskEntity>(HiveTaskDataSource(Hive.box(taskBoxName))),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xff1D2830);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
              titleLarge: TextStyle(fontWeight: FontWeight.bold))),
          inputDecorationTheme: const InputDecorationTheme(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(color: secondaryTextColor),
              border: InputBorder.none,
              iconColor: secondaryTextColor),
          colorScheme: const ColorScheme.light(
              primary: primaryColor,
              primaryVariant: primaryVariantColor,
              background: Color(0xffF3F5F8),
              onSurface: primaryTextColor,
              onPrimary: Colors.white,
              onBackground: primaryTextColor,
              secondary: primaryColor,
              onSecondary: Colors.white)),
      home: HomeScreen(),
    );
  }
}
