import 'package:flutter/material.dart';
import 'package:untitled/constants/colours.dart';
import 'package:untitled/widgets/todo_list.dart';
import '../model/db_model.dart';
import '../model/todo_model.dart';
import 'package:untitled/widgets/user_input.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  var db = DatabaseConnect();

  // function to add todo
  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  // function to delete todo
  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: const Text('ToDo App', style: TextStyle(color: tdBlack, fontSize: 30),),
      ),
      backgroundColor: tdBGColor,
      body: Column(
        children: [
          Todolist(insertFunction: addItem, deleteFunction: deleteItem),
          UserInput(insertFunction: addItem),
        ],
      ),
    );
  }
}