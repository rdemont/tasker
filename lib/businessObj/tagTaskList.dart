import 'tagTask.dart';
import '../generate/businessObj/tagTaskListGen.dart';



class TagTaskList extends TagTaskListGen
{

  static Future<List<TagTask>> getAll([String? order]){
    return TagTaskListGen.getAll(order : order);
  }


  static Future<List<TagTask>> getQuery({String? order, String? where}){
    return TagTaskListGen.getQuery(order:order,where:where);
    
  }    
}