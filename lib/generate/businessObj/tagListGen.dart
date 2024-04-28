import '../../businessObj/tag.dart';
import '../../services/databaseService.dart';
import 'tagGen.dart';



class TagListGen
{

  
  static Future<List<Tag>> getAll({String? order}){
    return DatabaseService.initializeDb().then((db) {
      return db.query(TagGen.TABLE_NAME,orderBy: order??TagGen.COLUMN_ID).then((raws) async {
        List<Tag> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await TagGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }



  static Future<List<Tag>> getQuery({String? order, String? where}){
    return DatabaseService.initializeDb().then((db) {
      return db.query(TagGen.TABLE_NAME,orderBy: order??TagGen.COLUMN_ID, where: where).then((raws) async {
        List<Tag> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await TagGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }

}