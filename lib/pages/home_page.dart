import 'package:flutter/material.dart';
import 'package:todo_app/data/data_base.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
  if (_myBox.get('TODOLIST') == null){
    db.createInitialData();
  } else{
    db.loadData();
  }

    super.initState();
  }
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1]= !db.toDoList[index][1];
    });
    db.updateDataBase();
  }
  void saveNewTask(){
  setState(() {
    db.toDoList.add([_controller.text, false]);
    _controller.clear();
  });
  Navigator.of(context).pop();
  db.updateDataBase();
  }
  void createNewTask() {
    showDialog(context: context, builder: (context) {
    return DialogBox(
      controller: _controller,
      onSave: saveNewTask,
        onCancel: ()=> Navigator.of(context).pop(),
    );
    },
    );
  }

  void deleteTask(int index){
  setState(() {
    db.toDoList.removeAt(index);
  });
  db.updateDataBase();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
    appBar: AppBar(
      backgroundColor: Colors.yellow,
      title: Text('TO DO'),
      centerTitle: true,
      elevation: 0,
    ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context)=> deleteTask(index),
          );
        },
      ),
    );
  }
}
// children: [
// TodoTile(
// taskName: 'Make Tutorials',
// taskCompleted: true,
// onChanged: (p0){},
// ),
// TodoTile(
// taskName: 'Do Exercise',
// taskCompleted: false,
// onChanged: (p0){},
// )
// ],