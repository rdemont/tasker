



import 'package:flutter/material.dart';
import 'package:tasker/businessObj/tagTask.dart';
import 'package:tasker/generate/businessObj/tagListGen.dart';
import 'package:tasker/generate/businessObj/tagTaskGen.dart';
import 'package:tasker/widget/tagsWidget.dart';

import '../businessObj/tag.dart';
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

  bool _isLoaded = false ; 

  List<Tag> _allTags = [];
  List<Tag> _selectedTag = [] ; 

   @override
  void initState() {
    super.initState();
    nameController.text = widget.task.name.toString();
    descriptionController.text = widget.task.description.toString();
    Future.wait([
      TagListGen.getAll().then((value) {
        _allTags = value ;  
      }),

      widget.task.getTags().then((value) {
        _selectedTag = value ; 
      }),
    ]).then((value) {
        setState(() {
          _isLoaded = true ; 
        });
      
    });
  }

  Widget getBody()
  {
    return  Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child: 

        Column(
          
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
            Expanded(
              child:TagsWidget(allTags: _allTags,selectedTag:_selectedTag,)
            ),
    
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
      );
  }


  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Task"),
      ),
      body: _isLoaded ? getBody(): Text("Loading ... "),
    );
  }

  save()
  {
    widget.task.name = nameController.text;
    widget.task.description = descriptionController.text;
    widget.task.save().then((value){

print("Task ID : ${widget.task.id}");
      widget.task.getTagTaskList().then((ttList) {

print("TagTask Length : ${ttList.length}");
        for (TagTask tt in ttList)
        {
          tt.delete(); 
        }
print("_selectedTag Length : ${_selectedTag.length}");
        for (Tag tag in _selectedTag)
        {
          if (tag.id == 0 )
          {
            tag.save().then((value) {
              TagTask newTt = TagTaskGen.newObj(); 
              newTt.tag = tag ; 
              newTt.task = widget.task ; 
              newTt.save() ; 
            });
          }else {
            TagTask tt = ttList.firstWhere((element) => element.tagId == tag.id, orElse: () {
              TagTask newTt = TagTaskGen.newObj(); 
              newTt.tag = tag ; 
              newTt.task = widget.task ; 
              ttList.add(newTt);
              return newTt ;               
            },);
            tt.undelete(); 

          }
        }

        for (TagTask tt in ttList)
        {
          tt.save(); 
        }



      });
      

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