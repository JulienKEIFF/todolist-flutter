import 'package:flutter/material.dart';
import 'package:eventify/eventify.dart';
import 'package:tp_flutter/repository/database_helper.dart';
import 'package:tp_flutter/components/item.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  static of(BuildContext context, {bool root = false}) => root
      ? context.findRootAncestorStateOfType<_ItemList>()
      : context.findAncestorStateOfType<_ItemList>();

  @override
  State<ItemList> createState() => _ItemList();
}

class _ItemList extends State<ItemList> {
  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    EventEmitter emmiter = DatabaseHelper().getEmitter();
    emmiter.on('refresh', null, (ev, cont) {
      refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: DatabaseHelper().todoItems(),
      initialData: const [],
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return _buildRow(snapshot.data![i]);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget _buildRow(TodoItem item) {
    return Item(todoItem: item);
  }
}
