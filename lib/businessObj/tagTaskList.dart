import 'tagTask.dart';
import '../generate/businessObj/tagTaskListGen.dart';



class TagTaskList extends TagTaskListGen
{

  static Future<List<TagTask>> getAll([String? order]){
    return TagTaskListGen.getAll(order);
  }
}