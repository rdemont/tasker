import '../databaseObj/taskDBGen.dart';
import '../../businessObj/task.dart';
import '../../businessObj/businessObj.dart';
import '../../businessObj/taskGroup.dart';


class TaskGen extends BusinessObj
{
  TaskDBGen get _localDbObj => dbObj as TaskDBGen ;

  TaskGen(super.dbObj);

  static const String TABLE_NAME = "task";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TASKGROUPID = "taskGroupId";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_DESCRIPTION = "description";
  static const String COLUMN_ISDONE = "isDone";
  static const String COLUMN_INSERTTIME = "insertTime";
  static const String COLUMN_UPDATETIME = "updateTime";



  TaskGroup get taskGroup => _localDbObj.taskGroup;
  int get taskGroupId => _localDbObj.taskGroupId;
  String get name => _localDbObj.name;
  String get description => _localDbObj.description;
  String get isDone => _localDbObj.isDone;
  DateTime get insertTime => _localDbObj.insertTime;
  DateTime get updateTime => _localDbObj.updateTime;


  set taskGroupId(int value)
  {
    _localDbObj.taskGroupId = value;
  }
  set name(String value)
  {
    _localDbObj.name = value;
  }
  set description(String value)
  {
    _localDbObj.description = value;
  }
  set isDone(String value)
  {
    _localDbObj.isDone = value;
  }
  set insertTime(DateTime value)
  {
    _localDbObj.insertTime = value;
  }
  set updateTime(DateTime value)
  {
    _localDbObj.updateTime = value;
  }


  static Task newObj(){
    TaskDBGen objDb = TaskDBGen();
    return objDb.newObj();
  }

  static Future<Task> openObj(int id){
    TaskDBGen objDb = TaskDBGen();
    return objDb.open(id);
  }

  static Future<Task> fromMap(Map<String,Object?>map){
    TaskDBGen objDb = TaskDBGen();
    return objDb.fromMap(map);
  }


}