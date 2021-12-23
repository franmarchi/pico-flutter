import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Excluir extends StatefulWidget {
  const Excluir({Key? key}) : super(key: key);

  @override
  _ExcluirState createState() => _ExcluirState();
}

class _ExcluirState extends State<Excluir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Container(
        child: Column(
          children: [
            Text("data1"),
            Text("data1"),
            Row(
              children: [
                Text("data1"),
                Text("data1"),
                Text("data1"),
                Text("data1"),
                Text("data1"),
              ],
            ),
            Text("data1"),
            Text("data1"),
            Text("data1"),
          ],
        ),
      ),
    );
  }
}
