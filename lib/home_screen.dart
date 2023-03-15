import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/hidden_screen.dart';

import 'add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildNote(int index) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text(
            "Note Title",
            style: TextStyle(
              fontFamily: 'Mordred',
              color: Colors.black,
            ),
          ),
          subtitle: const Text(
            'March 13, 2023 - High',
            style: TextStyle(
              fontFamily: 'Mordred',
              color: Colors.black54,
            ),
          ),
          trailing: Checkbox(
            checkColor: Colors.black,
            tristate: true,
            onChanged: (value) {
              // print(value);
            },
            activeColor: Theme.of(context).primaryColor,
            value: true,
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
              builder: (_) => AddToDoScreen(),
            ),
          );
        },
        child: const Icon(Icons.ac_unit_rounded),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        itemCount: 10,
        itemBuilder: (BuildContext conntext, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'MY TASK',
                    style: TextStyle(
                      color: Colors.black38,
                      fontFamily: 'Binary X CHR',
                      fontSize: 40,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '0 of 10 Completed',
                    style: TextStyle(
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
          return _buildNote(index);
        },
      ),
    );
  }
}
