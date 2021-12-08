import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:eventify/eventify.dart';

class DatabaseHelper {
  String dbName = 'todo_database.db';
  String tableName = 'todo_items';

  String columnId = 'id';
  String columnTitle = 'title';
  String columnDescription = 'description';
  String columnDone = 'isDone';

  EventEmitter emmiter = EventEmitter();

  late Future<Database> database;

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // Initialisation de la DB
  Future initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDescription TEXT, $columnDone BOOLEAN)',
        );
      },
      version: 1,
    );

    database.whenComplete(() => print('ready'));
  }

  // Récuperation de l'emmiter
  EventEmitter getEmitter() {
    return emmiter;
  }

  // Ajout d'une tâche
  Future<void> insertTodoItem(TodoItem todoItem) async {
    final db = await database;

    await db.insert(
      tableName,
      todoItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    emmiter.emit('refresh', null);
  }

  // Récupération de toutes les tâches
  Future<List<TodoItem>> todoItems() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    List<TodoItem> list = List.generate(maps.length, (i) {
      return TodoItem(
        id: maps[i][columnId],
        title: maps[i][columnTitle],
        description: maps[i][columnDescription],
        isDone: maps[i][columnDone] == 1 ? true : false,
      );
    });

    return list;
  }

  // Mise à jour d'une tâche
  Future<void> updateTodoItem(TodoItem todoItem) async {
    final db = await database;

    await db.update(
      tableName,
      todoItem.toMap(),
      where: 'id = ?',
      whereArgs: [todoItem.id],
    );

    emmiter.emit('refresh', null);
  }

  // Suppression d'une tâche
  Future<void> deleteTodoItem(int id) async {
    final db = await database;

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    emmiter.emit('refresh', null);
  }
}

// Classe d'un model de tâche
class TodoItem {
  final int id;
  final String title;
  final String description;
  final bool isDone;

  TodoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  @override
  String toString() {
    return 'TodoItem{id: $id, name: $title, description: $description, isDone: $isDone}';
  }
}
