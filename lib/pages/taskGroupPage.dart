


import 'package:flutter/material.dart';

import '../businessObj/taskGroup.dart';
import '../generate/businessObj/taskGroupGen.dart';

class TaskGroupPage extends StatefulWidget {
  
  final TaskGroup taskGroup ; 

  TaskGroupPage({super.key, TaskGroup? taskGroup}):this.taskGroup=taskGroup ?? TaskGroupGen.newObj();

  @override
  State<TaskGroupPage> createState() => _TaskGroupPageState();
}


class _TaskGroupPageState extends State<TaskGroupPage> {
  TextEditingController nameController = TextEditingController();


  
  @override
  void initState() {
    super.initState();
    nameController.text = widget.taskGroup.name.toString();    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:  Text("Task Group"),
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
                      decoration: InputDecoration(hintText: "Nom"), 
                    )
                )              
              ],
            ),            
            Expanded(child: Container()),
            Row(children: [
              ElevatedButton(onPressed: (){
                save();
              }, 
              child: Text("Save")),

              Expanded(child: Container()),
              
              ElevatedButton(onPressed: (){
                delete();
              }, 
              child: Text("Delete")),
              ElevatedButton(onPressed: () {
                cancel();
              },
              child: Text("Cancel")),
            ],)
          ],
        )
      )
    );
  }

  save()
  {
    widget.taskGroup.name = nameController.text;
    widget.taskGroup.save().then((value){
      Navigator.pop(context);
    });
  }

  delete()
  {
    widget.taskGroup.delete();
    widget.taskGroup.save().then((value){
      Navigator.pop(context);
    });
  }

  cancel(){
    Navigator.pop(context);
  }

}
