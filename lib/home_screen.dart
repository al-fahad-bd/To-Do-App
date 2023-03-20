import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/database/database.dart';
import 'package:todo/hidden_screen.dart';
import 'package:todo/models/task_model.dart';
// import 'package:sqflite/sqflite.dart';

import 'add_todo_screen.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  // const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Task>> _taskList;

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  // ignore: unused_field
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    _taskList = DatabaseHelper.instance.getTaskList();
  }

  Widget _buildTask(Task task) {
    return Column(
      children: [
        ListTile(
          title: Text(
            task.title!,
            style: TextStyle(
              fontFamily: 'Mordred',
              color: task.status == 0 ? Colors.black87 : Colors.black12,
              decoration: task.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(
            '${_dateFormatter.format(task.date!)} - ${task.priority}',
            style: TextStyle(
              fontFamily: 'Mordred',
              color: task.status == 0 ? Colors.black87 : Colors.black12,
              decoration: task.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          trailing: Checkbox(
            checkColor: Colors.black,
            tristate: false,
            onChanged: (value) {
              // print(value);
              task.status = value! ? 1 : 0;
              DatabaseHelper.instance.updateTask(task);
              _updateTaskList();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ),
              );
            },
            activeColor: Theme.of(context).primaryColor,
            value: task.status == 1 ? true : false,
          ),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => AddToDoScreen(
                updateTaskList: _updateTaskList(),
                task: task,
              ),
            ),
          ),
        ),
        const Divider(
          height: 20,
          thickness: 20,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[100],
      appBar: AppBar(
        leading: GestureDetector(
          onLongPress: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => const HiddenScreen(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
            // child: Icon(
            //   Icons.tornado_rounded,
            //   color: Colors.lime[100],
            //   size: 30,
            // ),
            // child: Image.asset(
            //   'assets/images/box.gif',
            //   fit: BoxFit.cover,
            // ),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/box.gif',
              ),
            ),
          ),
        ),
        title: const Text(
          'Things To Do',
          style: TextStyle(fontFamily: 'Binary X CHR', fontSize: 36),
        ),
        elevation: 60,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => AddToDoScreen(
                updateTaskList: _updateTaskList,
              ),
            ),
          );
        },
        child: const Icon(Icons.ac_unit_rounded),
      ),
      body: FutureBuilder(
        future: _taskList,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 10,
                backgroundColor: Colors.lime,
                color: Colors.black26,
              ),
            );
          }

          final int completedTaskCount = snapshot.data!
              .where((Task task) => task.status == 1)
              .toList()
              .length;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            itemCount: int.parse(snapshot.data!.length.toString()) + 1,
            itemBuilder: (BuildContext conntext, int index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'MY TASK',
                        style: TextStyle(
                          color: Colors.black38,
                          fontFamily: 'Binary X CHR',
                          fontSize: 40,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$completedTaskCount out of ${snapshot.data.length} Completed',
                        style: const TextStyle(
                          color: Colors.black38,
                          fontFamily: 'Binary X CHR',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return _buildTask(snapshot.data![index - 1]);
            },
          );
        },
      ),
    );
  }
}
