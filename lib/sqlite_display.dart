import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(const MaterialApp(home: SQLiteDisplay()));

class SQLiteDisplay extends StatefulWidget {
  const SQLiteDisplay({super.key});
  @override
  State<SQLiteDisplay> createState() => _SQLiteDisplayState();
}

class _SQLiteDisplayState extends State<SQLiteDisplay> {
  List<Map<String, dynamic>> _records = [];

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  _fetchRecords() async {
    final db = await openDatabase(join(await getDatabasesPath(), 'students_db.db'));
    final List<Map<String, dynamic>> maps = await db.query('students');
    setState(() => _records = maps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLite Display Records")),
      body: ListView.builder(
        itemCount: _records.length,
        itemBuilder: (context, index) => ListTile(
          leading: Text(_records[index]['id'].toString()),
          title: Text(_records[index]['name']),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _fetchRecords, child: const Icon(Icons.refresh)),
    );
  }
}
