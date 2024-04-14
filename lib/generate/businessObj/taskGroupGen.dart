import '../databaseObj/taskGroupDBGen.dart';
import '../../businessObj/taskGroup.dart';
import '../../businessObj/businessObj.dart';


class TaskGroupGen extends BusinessObj
{
  TaskGroupDBGen get _localDbObj => dbObj as TaskGroupDBGen ;

  TaskGroupGen(super.dbObj);

  static const String TABLE_NAME = "taskGroup";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_INSERTTIME = "insertTime";
  static const String COLUMN_UPDATETIME = "updateTime";



  String get name => _localDbObj.name;
  DateTime get insertTime => _localDbObj.insertTime;
  DateTime get updateTime => _localDbObj.updateTime;


  set name(String value)
  {
    _localDbObj.name = value;
  }
  set insertTime(DateTime value)
  {
    _localDbObj.insertTime = value;
  }
  set updateTime(DateTime value)
  {
    _localDbObj.updateTime = value;
  }


  static TaskGroup newObj(){
    TaskGroupDBGen objDb = TaskGroupDBGen();
    return objDb.newObj();
  }

  static Future<TaskGroup> openObj(int id){
    TaskGroupDBGen objDb = TaskGroupDBGen();
    return objDb.open(id);
  }

  static Future<TaskGroup> fromMap(Map<String,Object?>map){
    TaskGroupDBGen objDb = TaskGroupDBGen();
    return objDb.fromMap(map);
  }


}