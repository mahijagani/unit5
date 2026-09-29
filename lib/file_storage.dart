import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MaterialApp(home: FileStorageApp()));

class FileStorageApp extends StatefulWidget {
  const FileStorageApp({super.key});
  @override
  State<FileStorageApp> createState() => _FileStorageAppState();
}

class _FileStorageAppState extends State<FileStorageApp> {
  final TextEditingController _controller = TextEditingController();
  String _fileContent = "";

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/note.txt');
  }

  _writeToFile() async {
    final file = await _getLocalFile();
    await file.writeAsString(_controller.text);
    _controller.clear();
    _readFromFile();
  }

  _readFromFile() async {
    try {
      final file = await _getLocalFile();
      String contents = await file.readAsString();
      setState(() => _fileContent = contents);
    } catch (e) {
      setState(() => _fileContent = "Error reading file / File empty");
    }
  }

  @override
  void initState() {
    super.initState();
    _readFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Local File Storage")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _controller, decoration: const InputDecoration(labelText: "Enter text to save")),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _writeToFile, child: const Text("Write to File")),
                ElevatedButton(onPressed: _readFromFile, child: const Text("Read File")),
              ],
            ),
            const SizedBox(height: 20),
            Text("File Content: $_fileContent", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
