import 'package:flutter/material.dart';
import 'package:tp_flutter/page/add_page.dart';

import 'repository/database_helper.dart';
import 'components/item_list.dart';

void main() async {
  await DatabaseHelper().initDatabase();
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PageLayout(),
    );
  }
}

class PageLayout extends StatelessWidget {
  const PageLayout({Key? key}) : super(key: key);

  void openEditor(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: const ItemList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openEditor(context);
        },
        tooltip: 'Ajouter une tâche',
        child: const Icon(Icons.add),
      ),
    );
  }
}
