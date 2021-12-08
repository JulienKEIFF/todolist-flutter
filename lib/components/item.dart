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

  openInfos(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(todoItem.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todoItem.description),
                Row(
                  children: [
                    const Text("Statut de la tâche :    "),
                    Icon(
                        todoItem.isDone
                            ? Icons.done_rounded
                            : Icons.info_outline,
                        size: 25,
                        color: todoItem.isDone ? Colors.green : Colors.red)
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      color: todoItem.isDone ? Colors.green : Colors.white,
      child: InkWell(
        onTap: () => openInfos(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(todoItem.title,
                  style: TextStyle(
                      fontSize: 17,
                      color: todoItem.isDone ? Colors.white : Colors.black)),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: todoItem.isDone ? Colors.white : Colors.grey[800],
                  size: 20,
                ),
                onPressed: () => openItemPage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
