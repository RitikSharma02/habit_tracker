import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'pages/home_page.dart';


void main() async {
  // initialization
 await Hive.initFlutter();
 // opening a database

await Hive.openBox("Habit_Database");

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
primarySwatch: Colors.green,
      ),
      home: Homepage(),
    );
  }
}

