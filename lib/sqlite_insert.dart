import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(const MaterialApp(home: SQLiteInsert()));

class SQLiteInsert extends StatefulWidget {
  const SQLiteInsert({super.key});
  @override
  State<SQLiteInsert> createState() => _SQLiteInsertState();
}

class _SQLiteInsertState extends State<SQLiteInsert> {
  Database? _database;
  final TextEditingController _nameController = TextEditingController();
  String _status = "";

  @override
  void initState() {
    super.initState();
    _initDB();
  }

  _initDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'students_db.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)");
      },
      version: 1,
    );
  }

  _insertRecord() async {
    if (_database == null || _nameController.text.isEmpty) return;
    await _database!.insert('students', {'name': _nameController.text});
    setState(() {
      _status = "Inserted: ${_nameController.text}";
      _nameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLite Insert Student")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Student Name")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _insertRecord, child: const Text("Insert Record")),
            const SizedBox(height: 20),
            Text(_status, style: const TextStyle(fontSize: 16, color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
