import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(const MaterialApp(home: SQLiteDelete()));

class SQLiteDelete extends StatefulWidget {
  const SQLiteDelete({super.key});
  @override
  State<SQLiteDelete> createState() => _SQLiteDeleteState();
}

class _SQLiteDeleteState extends State<SQLiteDelete> {
  final TextEditingController _idController = TextEditingController();
  String _status = "";

  _deleteRecord() async {
    final db = await openDatabase(join(await getDatabasesPath(), 'students_db.db'));
    int id = int.tryParse(_idController.text) ?? 0;
    int count = await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
    setState(() => _status = count > 0 ? "Deleted successfully!" : "ID not found!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLite Delete Record")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _idController, decoration: const InputDecoration(labelText: "Enter Student ID to Delete")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _deleteRecord, child: const Text("Delete Record")),
            const SizedBox(height: 20),
            Text(_status, style: const TextStyle(fontSize: 16, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
