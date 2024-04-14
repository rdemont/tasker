import '../../businessObj/taskGroup.dart';
import '../businessObj/taskGroupGen.dart';
import '../../databaseObj/databaseObj.dart';


class TaskGroupDBGen extends DatabaseObj {
  
  String _name = '';
  DateTime _insertTime = DateTime.now();
  DateTime _updateTime = DateTime.now();



  TaskGroupDBGen()
  {
    tableName = 'taskGroup';
  }

  String get name => _name;
  DateTime get insertTime => _insertTime;
  DateTime get updateTime => _updateTime;



  set name(String value)
  {
    if (_name != value)
    {
      dataUpdated(); 
      _name = value;
    }
  }
  set insertTime(DateTime value)
  {
    if (_insertTime != value)
    {
      dataUpdated(); 
      _insertTime = value;
    }
  }
  set updateTime(DateTime value)
  {
    if (_updateTime != value)
    {
      dataUpdated(); 
      _updateTime = value;
    }
  }


  Future<TaskGroup> open(int id)
  {
    return query(TaskGroupGen.TABLE_NAME,where: TaskGroupGen.COLUMN_ID+" = $id").then((obj)
    {
      TaskGroup result = TaskGroup(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);

      }
      return result ; 
    });
  }

  TaskGroup newObj()
  {
    TaskGroup result = TaskGroup(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    return{
      TaskGroupGen.COLUMN_NAME : _name,
      TaskGroupGen.COLUMN_INSERTTIME : _insertTime.millisecondsSinceEpoch,
      TaskGroupGen.COLUMN_UPDATETIME : _updateTime.millisecondsSinceEpoch,

    };
    
  }


  Future<TaskGroup> fromMap(Map<String,Object?> map)
  async {
    TaskGroup result = TaskGroup(this) ;
    super.id = map[TaskGroupGen.COLUMN_ID] as int; 
    
    _name = (map[TaskGroupGen.COLUMN_NAME]??'') as String;
    _insertTime = DateTime.fromMillisecondsSinceEpoch((map[TaskGroupGen.COLUMN_INSERTTIME]??0) as int);
    _updateTime = DateTime.fromMillisecondsSinceEpoch((map[TaskGroupGen.COLUMN_UPDATETIME]??0) as int);



    return result; 

  }



}