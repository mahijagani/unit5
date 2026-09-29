import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(const MaterialApp(home: SQLiteUpdate()));

class SQLiteUpdate extends StatefulWidget {
  const SQLiteUpdate({super.key});
  @override
  State<SQLiteUpdate> createState() => _SQLiteUpdateState();
}

class _SQLiteUpdateState extends State<SQLiteUpdate> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _status = "";

  _updateRecord() async {
    final db = await openDatabase(join(await getDatabasesPath(), 'students_db.db'));
    int id = int.tryParse(_idController.text) ?? 0;
    int count = await db.update(
      'students',
      {'name': _nameController.text},
      where: 'id = ?',
      whereArgs: [id],
    );
    setState(() => _status = count > 0 ? "Updated successfully!" : "ID not found!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLite Update Record")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _idController, decoration: const InputDecoration(labelText: "Enter Student ID to Update")),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Enter New Name")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _updateRecord, child: const Text("Update Record")),
            const SizedBox(height: 20),
            Text(_status, style: const TextStyle(fontSize: 16, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
