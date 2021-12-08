import 'package:flutter/material.dart';
import 'package:tp_flutter/repository/database_helper.dart';

import '../page/update_page.dart';

class Item extends StatelessWidget {
  const Item({Key? key, required this.todoItem}) : super(key: key);

  final TodoItem todoItem;

  openItemPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePage(
          todoItem: todoItem,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      color: todoItem.isDone ? Colors.green : Colors.white,
      child: InkWell(
        onTap: () => openItemPage(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(todoItem.title, style: const TextStyle(fontSize: 17)),
              const Spacer(),
              Checkbox(value: todoItem.isDone, onChanged: null),
            ],
          ),
        ),
      ),
    );
  }
}
