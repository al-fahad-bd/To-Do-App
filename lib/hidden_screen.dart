import 'package:flutter/material.dart';

class HiddenScreen extends StatefulWidget {
  const HiddenScreen({super.key});

  @override
  State<HiddenScreen> createState() => _HiddenScreenState();
}

class _HiddenScreenState extends State<HiddenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('Welcome to hidden page'),
      // ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 10),
              child: Image.asset('assets/images/box.gif'),
            ),
            const SizedBox(
              height: 80,
            ),
            const Text(
              "Made by Fahad",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Mordred',
                  fontWeight: FontWeight.bold,
                  color: Colors.limeAccent),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Copyright © 2023 fahad.inc - All rights reserved",
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Mordred',
                  fontWeight: FontWeight.bold,
                  color: Colors.limeAccent),
            ),
          ],
        ),
      ),
    );
  }
}
