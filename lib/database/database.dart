import 'dart:io';
// import 'dart:js_util';

// import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db = null;

  DatabaseHelper._instance();

  String taskTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  /*
    This is how the task table will look
    Id / Title / Date / Priority / Status
    0     --      --      --         0
    1     --      --      --         1
    2     --      --      --         2
  */

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';
    final todoListDB =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDB;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)',
    );
  }

  // create database
  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(taskTable);
    return result;
  }

  // read from database
  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();

    final List<Task> taskList = [];

    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    taskList.sort((taskA, taskB) => taskA.date!.compareTo(taskB.date!));
    return taskList;
  }

  // write to database
  Future<int> insertTask(Task task) async {
    Database? db = await this.db;
    final int result = await db!.insert(
      taskTable,
      task.toMap(),
    );
    return result;
  }

  // update the database
  Future<int> updateTask(Task task) async {
    Database? db = await this.db;
    final int result = await db!.update(
      taskTable,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
    return result;
  }

  // delete the database
  Future<int> deleteTask(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(
      taskTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}
