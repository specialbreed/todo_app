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
      drawer: Drawer(
        child: Container(
          color: Colors.yellow.shade200,
          child: ListView(
            children: [
             ListTile(
               leading: Icon(Icons.file_upload),
               title: Text('Upload shot'),
               onTap: () => print('Upload tapped'),
             ),
              SizedBox(height: 20),

              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile tapped'),
                onTap: () => print('Profile tapped'),
              ),
              SizedBox(height: 20),

              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
                onTap: () => print('Message tapped'),
              ),
              SizedBox(height: 20),

              ListTile(
                leading: Icon(Icons.line_axis),
                title: Text('Stats'),
                onTap: () => print('Stats tapped'),
              ),
              SizedBox(height: 20),

              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () => print('Share tapped'),
              ),
              SizedBox(height: 20),

              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                onTap: () => print('Notification tapped'),
              ),
              SizedBox(height: 20),

              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Setting'),
                onTap: () => print('Setting tapped'),
              ),
              SizedBox(height: 20),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sign Out'),
                onTap: () => print('Logout tapped'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
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