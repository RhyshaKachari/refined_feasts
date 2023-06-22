import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.deepOrange,
          ),
          SafeArea(
              child: Column(
                children: [
                  Text("Text 1"),
                  Text("Text 2"),
                ],

          ))

        ],
      ),
    );
  }
}
