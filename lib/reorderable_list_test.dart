import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';

class Reorder_Test extends StatefulWidget {
  @override
  _Reorder_TestState createState() => _Reorder_TestState();
}

class _Reorder_TestState extends State<Reorder_Test> {
  List<Widget> _rows = List<Widget>();

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 5; i++)
      _rows.add(Container(
        child: Center(child: Text(i.toString())),
        key: ValueKey(i.toString()),
        width: 80,
        height: 100,
      ));
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _rows.removeAt(oldIndex);
        _rows.insert(newIndex, row);
      });
    }

    return Scaffold(
      body: ReorderableRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _rows,
        onReorder: _onReorder,
        onNoReorder: (int index) {
          print("/////////////////////////");
        },
      ),
    );
  }
}
