import '../../businessObj/task.dart';
import '../../services/databaseService.dart';
import 'taskGen.dart';



class TaskListGen
{

  
  static Future<List<Task>> getAll({String? order}){
    return DatabaseService.initializeDb().then((db) {
      return db.query(TaskGen.TABLE_NAME,orderBy: order??TaskGen.COLUMN_ID).then((raws) async {
        List<Task> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await TaskGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }



  static Future<List<Task>> getQuery({String? order, String? where}){
    return DatabaseService.initializeDb().then((db) {
      return db.query(TaskGen.TABLE_NAME,orderBy: order??TaskGen.COLUMN_ID, where: where).then((raws) async {
        List<Task> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await TaskGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }

}