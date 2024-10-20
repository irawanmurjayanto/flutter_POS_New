import 'package:flutter/material.dart';

class Finance1 extends StatefulWidget {
  const Finance1({super.key});

  @override
  State<Finance1> createState() => _Finance1State();
}

class _Finance1State extends State<Finance1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Finance Menu'),),
    );
  }
}