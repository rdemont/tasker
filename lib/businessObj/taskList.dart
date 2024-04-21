import '../generate/businessObj/taskGen.dart';
import '../services/databaseService.dart';
import 'task.dart';
import '../generate/businessObj/taskListGen.dart';



class TaskList extends TaskListGen
{

  static Future<List<Task>> getAll([String? order]){
    return TaskListGen.getAll(order);
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

  
  static Future<List<Task>> getFromTags(List<int> tagsId){
    return DatabaseService.initializeDb().then((db) {
      return db.query("task",where: "tagId IN $tagsId" ,orderBy: "insertTime DESC").then((raws) async {
        List<Task> result = [];      
        for(int i=0;i<raws.length;i++)
        {
          result.add(await TaskGen.fromMap(raws[i]));
          
        }
        return result;
      });
    });
  }

}