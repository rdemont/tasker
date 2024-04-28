import 'package:tasker/generate/businessObj/tagTaskListGen.dart';


import '../generate/businessObj/taskGen.dart';
import '../services/databaseService.dart';
import 'tag.dart';
import 'tagTask.dart';
import 'task.dart';
import '../generate/businessObj/taskListGen.dart';



class TaskList extends TaskListGen
{

  static Future<List<Task>> getAll([String? order]){
    return TaskListGen.getAll(order :order);
  }


  
  static Future<List<Task>> getFromTaskGroup(int taskGroupId){
    return DatabaseService.initializeDb().then((db) {
      return db.query("task",where: "taskGroupId = $taskGroupId" ,orderBy: "insertTime DESC").then((raws) async {
        List<Task> result = [];      
        for(int i=0;i<raws.length;i++)
        {
          result.add(await TaskGen.fromMap(raws[i]));
          
        }
        return result;
      });
    });
  }

  
  static Future<List<Task>> getFromTags(List<Tag> tags){
    List<Task> result = [];      
    String strIn = "(";
    for (Tag t in tags)
    {
      strIn = strIn + "${t.id},";
    }
    strIn = strIn.substring(0,strIn.length-1)+")" ;
    return TagTaskListGen.getQuery(where: "tagId IN $strIn").then((value) {
      for (TagTask tt  in value )
      {
        result.add(tt.task);
      }
      return result ; 
    });
  }

}