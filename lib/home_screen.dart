import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic _buildNote(int index) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Note Title"),
          subtitle: Text('March 13, 2023 - High'),
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
        leading: Icon(Icons.tornado_rounded),
        title: const Text(
          'Things To Do',
          style: TextStyle(fontFamily: 'Binary', fontSize: 36),
        ),
        elevation: 80,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
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
                      fontFamily: 'Binary',
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
                      fontFamily: 'Binary',
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
