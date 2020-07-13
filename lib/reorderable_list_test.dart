import 'package:flutter/material.dart';
import 'package:flutter_api_test/dish.dart';

import 'package:reorderables/reorderables.dart';

import 'funcs.dart';

class Reorder_Test extends StatefulWidget {
  final token;
  Reorder_Test({Key key, this.token}) : super(key: key);

  @override
  _Reorder_TestState createState() => _Reorder_TestState(token);
}

class _Reorder_TestState extends State<Reorder_Test> {
  final token;

  _Reorder_TestState(this.token);

  List<Widget> _rows = List<Widget>();
  Requests reqs = Requests();
  @override
  void initState() {
    super.initState();

    for (var i = 0; i < testlist.length; i++)
      _rows.add(Container(
        child: Center(child: Text(testlist[i].name)),
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
        Dish dish = testlist.removeAt(oldIndex);
        testlist.insert(newIndex, dish);
      });
    }

    return Scaffold(
      body: Column(
        children: [
          ReorderableRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _rows,
            onReorder: _onReorder,
            onNoReorder: (int index) {
              print("/////////////////////////");
            },
          ),
          FlatButton(
            onPressed: () async {
              testlist.forEach((element) {
                print(element.position.toString() + ' ' + element.name);
              });
              for (var i = 0; i < testlist.length; i++) {
                testlist[i].position = i;
                print(testlist[i].position.toString() + ' ' + testlist[i].name);
              }

              reqs.updateDishList(token, testlist);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
