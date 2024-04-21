



import 'package:flutter/material.dart';

import '../businessObj/task.dart';
import '../generate/businessObj/taskGen.dart';

class TaskPage extends StatefulWidget {
  
  final Task task;

  TaskPage({super.key, Task? task}):this.task=task ?? TaskGen.newObj();

  @override
  State<TaskPage> createState() => _TaskPageState();
}


class _TaskPageState extends State<TaskPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   @override
  void initState() {
    super.initState();
    nameController.text = widget.task.name.toString();
    descriptionController.text = widget.task.description.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Task"),
      ),
      
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [
            Row(
              children: [
                Text("Nom : "),
                Flexible(
                  child: TextField(
                      controller: nameController,
                      decoration:  InputDecoration(hintText: "Nom"), 
                    )
                )              
              ],
            ),
            Row(
              children: [
                Text("Description : "),
                Flexible(
                  child: TextField(
                      controller: descriptionController,
                      decoration:  InputDecoration(hintText: "Description"), 
                    )
                )              
              ],
            ),       
            Expanded(child: Container()),
            Row(children: [
              ElevatedButton(onPressed: (){
                save();
              }, 
              child: Text("Sauver")),

              Expanded(child: Container()),
              
              ElevatedButton(onPressed: (){
                delete();
              }, 
              child: Text("Supprimer")),
              ElevatedButton(onPressed: () {
                cancel();
              },
              child: Text("Annuler")),
            ],)
          ],
        )
      )
    );
  }

  save()
  {
    widget.task.name = nameController.text;
    widget.task.description = descriptionController.text;

    widget.task.save().then((value){

      Navigator.pop(context);
    });
  }

  delete()
  {
    widget.task.delete();
    widget.task.save().then((value){
      Navigator.pop(context);
    });
  }

  cancel(){
    Navigator.pop(context);
  }
}