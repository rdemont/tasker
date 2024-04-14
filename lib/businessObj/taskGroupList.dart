import 'taskGroup.dart';
import '../generate/businessObj/taskGroupListGen.dart';



class TaskGroupList extends TaskGroupListGen
{

  static Future<List<TaskGroup>> getAll([String? order]){
    return TaskGroupListGen.getAll(order);
  }
}