import 'package:flutter/material.dart';
import 'package:tasker/businessObj/tagList.dart';
import 'package:tasker/businessObj/taskGroupList.dart';
import 'package:tasker/generate/businessObj/tagGen.dart';
import 'package:tasker/generate/businessObj/taskGen.dart';
import 'package:tasker/pages/taskGroupPage.dart';

import '../businessObj/tag.dart';
import '../businessObj/task.dart';
import '../businessObj/taskGroup.dart';
import '../businessObj/taskList.dart';
import 'tagPage.dart';
import 'taskPage.dart';

class TaskListPage extends StatefulWidget {

  final TaskGroup taskGroup;
  TaskListPage({super.key,required TaskGroup taskGroup}):this.taskGroup = taskGroup;

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}


class _TaskListPageState extends State<TaskListPage> {

  late TaskGroup _taskGroup ;
  List<Tag> _tag = [] ; 
  List<Task> _taskList = [] ; 
  List<TaskGroup> _taskGroupList = [] ; 
  List<Tag> _tagList = [] ; 

  bool _isLoaded = false  ; 
  bool _showCheckedOnly = false ; 
  bool _showPerTags = false ; 

  @override
  void initState() {    
    super.initState();

    _taskGroup = widget.taskGroup; 

    //ToDo: Must to be change 
    _tag.add(TagGen.newObj());
    _tag[0].name = "Default";

  }

  @override
  Widget build(BuildContext context) {

    if (!_isLoaded)
    {
      Future.wait([
        TaskList.getFromTaskGroup(_taskGroup.id).then((value) {
          _taskList = value;
          //return ;
        },),

        TaskGroupList.getAll().then((value) {
          _taskGroupList = value ; 
          //return ;
        },),

        TagList.getAll().then((value) {
          _tagList = value ; 
          if (_tagList.length >0 )
          {
            _tag[0]= _tagList[0];
          }
          //return ;
        },),


      ]).then((value){
        setState(() {
print("*******************Is Loaded************ ") ;
          _isLoaded = true ;     
        });
        
      },);
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon:Icon(_showCheckedOnly?Icons.check_outlined:Icons.all_inclusive_outlined),
            tooltip: "Marteler",
            onPressed: () {
              setState(() {
                _showCheckedOnly = !_showCheckedOnly ;  
              });
              
            },
          ),
          IconButton(
            icon:Icon(_showPerTags?Icons.tag_outlined:Icons.group),
            tooltip: "Marteler",
            onPressed: () {
              setState(() {
                _isLoaded = false ;
                _showPerTags = !_showPerTags ;  
              });                
              TaskList.getFromTags([1,2]).then((value) {
                setState(() {
                  _taskList = value ;
                  _isLoaded = true ;                   
                });
              });
            },
          )
        ],
        title: Text((_showPerTags?getTagListName():_taskGroup.name), overflow: TextOverflow.ellipsis),
      ),
      drawer:_showPerTags?getTagsDrawer():getGroupDrawer(),       
      body: _isLoaded?getBody():getWaite(), 
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () {
          addTask();
        },
      ),
    );
  }

  Drawer getGroupDrawer()
  {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 100,
            child : DrawerHeader(
              child: Text("Groupe"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),            
          ),
          Expanded(child: 
            ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _taskGroupList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  //onLongPress: () => showSpecies(_speciesList[index]),
                  onTap: () {
                    TaskList.getFromTaskGroup(_taskGroupList[index].id).then((value) {
                      setState(() {
                        _taskGroup = _taskGroupList[index];  
                        _taskList = value ;   
                      });
                      
                    });
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    //leading: CircleAvatar(child: Text(_taskList[index].name)),
                    title: Text(_taskGroupList[index].name, overflow: TextOverflow.ellipsis),  
                  )               
                );
              }
            )
          ),
          TextButton.icon(onPressed:() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  TaskGroupPage())).then((value){
                TaskGroupList.getAll().then((value) {
                  setState(() {
                    _taskGroupList = value ;    
                  });
                });
              });
            }, 
            icon: Icon(Icons.add_circle_outline), 
            label: Text("Add group")
          )
        ]
      ),
    );
  }

  Drawer getTagsDrawer()
  {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 100,
            child : DrawerHeader(
              child: Text("Tags"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),            
          ),
          Expanded(child: 
            ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _tagList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {  
                      if (_tag.contains(_tagList[index]))
                      {
                        _tag.remove(_tagList[index]);
                      }else {
                        _tag.add(_tagList[index]);
                      }
                    });
                  },
                  child: ListTile(
                    //leading: CircleAvatar(child: Text(_taskList[index].name)),
                    title: Text(_tagList[index].name, overflow: TextOverflow.ellipsis),  
                    trailing: Icon(_tag.contains(_tagList[index]) ? Icons.check :Icons.cancel_outlined)       
                  )
                );
              }
            )
          ),
          TextButton.icon(onPressed:() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  TagPage())).then((value){
                TagList.getAll().then((value) {
                  setState(() {
                    _tagList = value ;    
                  });
                });
              });
            }, 
            icon: Icon(Icons.add_circle_outline), 
            label: Text("Add tag")
          )
        ]
      ),
    );
  }


  String getTagListName()
  {
    String result = "" ; 
    for(int i=0;i<_tag.length;i++)
    {
      result = result + _tag[i].name+"|" ;
    }
    result = result.substring(0,result.length-1);
    return result ; 
  }

  Widget getWaite()
  {
    return Text("Please waite .... ");
  }


  Widget getBody()
  {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _showPerTags?getTasksPerTag():getTasksPerGroup(),
        ]
      )
    );
  }



  Widget getTasksPerTag()
  {    
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
      child:ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _taskList.length,
          itemBuilder: (BuildContext context, int index) {
            return Visibility(
              visible: !_showCheckedOnly|(_showCheckedOnly&_taskList[index].isDone),
              child: GestureDetector(
                //onLongPress: () => showSpecies(_speciesList[index]),
                onTap: () => isDoneChange(_taskList[index]),
                child: ListTile(
                  leading: CircleAvatar(child: Text(_taskList[index].taskGroup.name, overflow: TextOverflow.fade)),
                  title: Text(_taskList[index].name, overflow: TextOverflow.ellipsis),  
                  subtitle: Text(_taskList[index].description, overflow: TextOverflow.ellipsis),
                  trailing: Icon(_taskList[index].isDone ? Icons.check :Icons.cancel_outlined)                    
                ) 
              )
            );
          }
        ),
    );      
  }

  Widget getTasksPerGroup()
  {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
      child:ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _taskList.length,
          itemBuilder: (BuildContext context, int index) {
            return Visibility(
              visible: !_showCheckedOnly|(_showCheckedOnly&_taskList[index].isDone),
              child: GestureDetector(
                //onLongPress: () => showSpecies(_speciesList[index]),
                onTap: () => isDoneChange(_taskList[index]),
                child: ListTile(
                  //leading: CircleAvatar(child: Text(_taskList[index].name)),
                  title: Text(_taskList[index].name),  
                  subtitle: Text(_taskList[index].description, overflow: TextOverflow.ellipsis),
                  trailing: Icon(_taskList[index].isDone ? Icons.check :Icons.cancel_outlined)                    
                ) 
              )
            );
          }
        ),
    );
  }

  
  isDoneChange(Task task)
  {
    setState(() {
      task.isDone = !task.isDone ;  
    });
    
    task.save();
  }

 addTask() {
    Task task = TaskGen.newObj();
    task.taskGroup = _taskGroup ; 
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  TaskPage(task: task,)  )
    ).then((value){
      TaskList.getFromTaskGroup(_taskGroup.id).then((value) {
        setState(() {
          _taskList = value ; 
        });
      });
    });
  }

}

