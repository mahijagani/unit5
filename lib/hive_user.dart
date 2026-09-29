import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(const MaterialApp(home: HiveUser()));
}

class HiveUser extends StatefulWidget {
  const HiveUser({super.key});
  @override
  State<HiveUser> createState() => _HiveUserState();
}

class _HiveUserState extends State<HiveUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  late Box _userBox;

  @override
  void initState() {
    super.initState();
    _userBox = Hive.box('userBox');
  }

  _saveUser() {
    final name = _nameController.text;
    final age = _ageController.text;
    if (name.isNotEmpty && age.isNotEmpty) {
      _userBox.put('userData', {'name': name, 'age': age});
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var userData = _userBox.get('userData');
    return Scaffold(
      appBar: AppBar(title: const Text("Hive User Name & Age")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: _ageController, decoration: const InputDecoration(labelText: "Age"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _saveUser, child: const Text("Save User")),
            const SizedBox(height: 20),
            if (userData != null)
              Text("Saved: ${userData['name']}, Age: ${userData['age']}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
