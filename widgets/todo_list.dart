import 'package:flutter/material.dart';
import '../model/db_model.dart';
import './todo_card.dart';

class Todolist extends StatelessWidget {
  final Function insertFunction;
  final Function deleteFunction;
  final db = DatabaseConnect();
  Todolist(
      {required this.insertFunction, required this.deleteFunction, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.getTodo(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data =
              snapshot.data;
          var datalength = data!.length;

          return datalength == 0
              ? const Center(
            child: Text('no data found'),
          )
              : ListView.builder(
            itemCount: datalength,
            itemBuilder: (context, i) => Todocard(
              id: data[i].id,
              title: data[i].title,
              creationDate: data[i].creationDate,
              isChecked: data[i].isChecked,
              insertFunction: insertFunction,
              deleteFunction: deleteFunction,
            ),
          );
        },
      ),
    );
  }
}