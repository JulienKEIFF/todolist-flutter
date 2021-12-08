import 'package:flutter/material.dart';
import 'package:tp_flutter/repository/database_helper.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key, required this.todoItem}) : super(key: key);

  final TodoItem todoItem;

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool firstBuild = true;
  String _title = "";
  String _description = "";
  bool _isDone = false;

  void initedBool() {
    if (firstBuild) {
      _isDone = widget.todoItem.isDone;
      firstBuild = false;
    }
  }

  void changeTodoTermined(bool value) {
    _isDone = !_isDone;
    setState(() {});
  }

  void changeTitle(String value) {
    _title = value;
  }

  void changeDescription(String value) {
    _description = value;
  }

  void updateTodo() {
    var item = TodoItem(
      id: widget.todoItem.id,
      title: _title == "" ? widget.todoItem.title : _title,
      description:
          _description == "" ? widget.todoItem.description : _description,
      isDone: _isDone,
    );
    DatabaseHelper().updateTodoItem(item);

    Navigator.pop(context);
  }

  void removeTodo() {
    DatabaseHelper().deleteTodoItem(widget.todoItem.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    initedBool();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todoItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              child: Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Nom de la tâche'),
                      initialValue: widget.todoItem.title,
                      onChanged: changeTitle,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Description de la tâche'),
                      initialValue: widget.todoItem.description,
                      onChanged: changeDescription,
                    ),
                    Row(
                      children: [
                        const Text('La tâche est déja terminée ?'),
                        const Spacer(),
                        Switch(
                          value: _isDone,
                          onChanged: changeTodoTermined,
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: removeTodo,
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            child: const Text('Suprimer')),
                        ElevatedButton(
                            onPressed: updateTodo,
                            child: const Text('Mettre à jour')),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
