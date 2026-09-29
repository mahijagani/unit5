import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(const MaterialApp(home: SQLiteProducts()));

class SQLiteProducts extends StatefulWidget {
  const SQLiteProducts({super.key});
  @override
  State<SQLiteProducts> createState() => _SQLiteProductsState();
}

class _SQLiteProductsState extends State<SQLiteProducts> {
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDB();
  }

  _initDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'products_db.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, price REAL)");
      },
      version: 1,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLite Products Table")),
      body: Center(child: Text(_database != null ? "Database and Products table created!" : "Initializing...")),
    );
  }
}
