import '../../businessObj/taskGroup.dart';
import '../../services/databaseService.dart';
import 'taskGroupGen.dart';



class TaskGroupListGen
{

  
  static Future<List<TaskGroup>> getAll([String? order]){
    return DatabaseService.initializeDb().then((db) {
      return db.query(TaskGroupGen.TABLE_NAME,orderBy: order??TaskGroupGen.COLUMN_ID).then((raws) async {
        List<TaskGroup> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await TaskGroupGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }
}