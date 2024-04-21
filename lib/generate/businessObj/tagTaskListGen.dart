import '../../businessObj/tagTask.dart';
import '../../services/databaseService.dart';
import 'tagTaskGen.dart';



class TagTaskListGen
{

  
  static Future<List<TagTask>> getAll([String? order]){
    return DatabaseService.initializeDb().then((db) {
      return db.query(TagTaskGen.TABLE_NAME,orderBy: order??TagTaskGen.COLUMN_ID).then((raws) async {
        List<TagTask> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await TagTaskGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }
}