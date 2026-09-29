import 'package:flutter/material.dart';
import 'sp_username.dart';
import 'sp_darkmode.dart';
import 'sqlite_products.dart';
import 'sqlite_insert.dart';
import 'sqlite_display.dart';
import 'sqlite_update.dart';
import 'sqlite_delete.dart';
import 'hive_todo.dart';
import 'hive_user.dart';
import 'file_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('todoBox');
  await Hive.openBox('userBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical Tasks',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {'title': 'SP: Save Username', 'page': const SPUsername()},
      {'title': 'SP: Dark Mode', 'page': const SPDarkModeApp()},
      {'title': 'SQLite: Products Table', 'page': const SQLiteProducts()},
      {'title': 'SQLite: Insert Student', 'page': const SQLiteInsert()},
      {'title': 'SQLite: Display Records', 'page': const SQLiteDisplay()},
      {'title': 'SQLite: Update Record', 'page': const SQLiteUpdate()},
      {'title': 'SQLite: Delete Record', 'page': const SQLiteDelete()},
      {'title': 'Hive: To-Do Note', 'page': const HiveTodo()},
      {'title': 'Hive: User Name & Age', 'page': const HiveUser()},
      {'title': 'File Storage: Read/Write', 'page': const FileStorageApp()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Practical Tasks Dashboard")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index]['title'] as String),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tasks[index]['page'] as Widget),
              );
            },
          );
        },
      ),
    );
  }
}
