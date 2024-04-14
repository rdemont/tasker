import 'task.dart';
import '../generate/businessObj/taskListGen.dart';



class TaskList extends TaskListGen
{

  static Future<List<Task>> getAll([String? order]){
    return TaskListGen.getAll(order);
  }
}