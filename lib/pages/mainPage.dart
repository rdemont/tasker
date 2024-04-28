


import 'package:flutter/material.dart';

import '../businessObj/taskGroup.dart';
import '../businessObj/taskGroupList.dart';
import 'taskGroupPage.dart';
import 'taskListPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {

  List<TaskGroup> _taskGroupList = [] ;
  
  late TaskGroup  _actifTaskGroup ; 
  bool _isLoaded = false ; 

  loadData()
  {
    if (_taskGroupList.isEmpty)
    {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TaskGroupPage()
          )
        );
      }); 
    } else {
      _actifTaskGroup = _taskGroupList[0] ; 
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TaskListPage(taskGroup: _actifTaskGroup )
          )
        );
      }); 
    }

  }


  @override
  void initState()  {
    super.initState();
    Future.wait([
      TaskGroupList.getAll().then((value) {
        _taskGroupList = value ;  
        return ;
      }),

    ]).then((value) {
      setState(() {
        _isLoaded = true ;   
      });
      
      loadData();
    });

  }

  @override
  Widget build(BuildContext context) {

    return _isLoaded?Text("Problème "):Text("Please waite ....loading ");  

  }
  
}