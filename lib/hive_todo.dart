import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todoBox');
  runApp(const MaterialApp(home: HiveTodo()));
}

class HiveTodo extends StatefulWidget {
  const HiveTodo({super.key});
  @override
  State<HiveTodo> createState() => _HiveTodoState();
}

class _HiveTodoState extends State<HiveTodo> {
  final TextEditingController _controller = TextEditingController();
  late Box _todoBox;

  @override
  void initState() {
    super.initState();
    _todoBox = Hive.box('todoBox');
  }

  _addTodo() {
    if (_controller.text.isNotEmpty) {
      _todoBox.add(_controller.text);
      _controller.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive To-Do Note")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(labelText: "To-Do Note"))),
                IconButton(icon: const Icon(Icons.add), onPressed: _addTodo),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _todoBox.listenable(),
              builder: (context, Box box, _) {
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(box.getAt(index).toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          box.deleteAt(index);
                          setState(() {});
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
