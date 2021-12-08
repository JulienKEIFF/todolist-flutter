import 'package:flutter/material.dart';

import '../repository/database_helper.dart';

class NewItemForm extends StatefulWidget {
  const NewItemForm({Key? key}) : super(key: key);

  @override
  State<NewItemForm> createState() => _NewItemForm();
}

class _NewItemForm extends State<NewItemForm> {
  var _title = "";
  var _description = "";
  var _newTodoIsTermined = false;

  void changeTodoTermined(bool value) {
    _newTodoIsTermined = !_newTodoIsTermined;
    setState(() {});
  }

  void changeTitle(String value) {
    _title = value;
  }

  void changeDescription(String value) {
    _description = value;
  }

  void addNewTodo() {
    var item = TodoItem(
      title: _title,
      description: _description,
      isDone: _newTodoIsTermined,
      id: DateTime.now().millisecondsSinceEpoch,
    );
    DatabaseHelper().insertTodoItem(item);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    onChanged: changeTitle,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Description de la tâche'),
                    onChanged: changeDescription,
                  ),
                  Row(
                    children: [
                      const Text('La tâche est déja terminée ?'),
                      const Spacer(),
                      Switch(
                        value: _newTodoIsTermined,
                        onChanged: changeTodoTermined,
                      )
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: addNewTodo, child: const Text('Ajouter'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
