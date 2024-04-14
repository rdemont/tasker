import '../../businessObj/task.dart';
import '../businessObj/taskGen.dart';
import '../../databaseObj/databaseObj.dart';
import '../../businessObj/taskGroup.dart';
import '../businessObj/taskGroupGen.dart';


class TaskDBGen extends DatabaseObj {
  
  TaskGroup _taskGroup = TaskGroupGen.newObj();
  int _taskGroupId = 0;
  String _name = '';
  String _description = '';
  String _isDone = '';
  DateTime _insertTime = DateTime.now();
  DateTime _updateTime = DateTime.now();



  TaskDBGen()
  {
    tableName = 'task';
  }

  TaskGroup get taskGroup => _taskGroup;
  int get taskGroupId => _taskGroupId;
  String get name => _name;
  String get description => _description;
  String get isDone => _isDone;
  DateTime get insertTime => _insertTime;
  DateTime get updateTime => _updateTime;



  set taskGroupId(int value)
  {
    if (_taskGroupId != value)
    {
      dataUpdated(); 
      _taskGroupId = value;
    }
  }
  set name(String value)
  {
    if (_name != value)
    {
      dataUpdated(); 
      _name = value;
    }
  }
  set description(String value)
  {
    if (_description != value)
    {
      dataUpdated(); 
      _description = value;
    }
  }
  set isDone(String value)
  {
    if (_isDone != value)
    {
      dataUpdated(); 
      _isDone = value;
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


  Future<Task> open(int id)
  {
    return query(TaskGen.TABLE_NAME,where: TaskGen.COLUMN_ID+" = $id").then((obj)
    {
      Task result = Task(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);
        TaskGroupGen.openObj(_taskGroupId).then((value){
          _taskGroup = value ;
        });

      }
      return result ; 
    });
  }

  Task newObj()
  {
    Task result = Task(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    return{
      TaskGen.COLUMN_TASKGROUPID : _taskGroupId,
      TaskGen.COLUMN_NAME : _name,
      TaskGen.COLUMN_DESCRIPTION : _description,
      TaskGen.COLUMN_INSERTTIME : _insertTime.millisecondsSinceEpoch,
      TaskGen.COLUMN_UPDATETIME : _updateTime.millisecondsSinceEpoch,

    };
    
  }


  Future<Task> fromMap(Map<String,Object?> map)
  async {
    Task result = Task(this) ;
    super.id = map[TaskGen.COLUMN_ID] as int; 
    
    _taskGroupId = (map[TaskGen.COLUMN_TASKGROUPID]??0) as int;
    if (_taskGroupId >0 )
    {
      _taskGroup = await TaskGroupGen.openObj(_taskGroupId);
    }
    _name = (map[TaskGen.COLUMN_NAME]??'') as String;
    _description = (map[TaskGen.COLUMN_DESCRIPTION]??'') as String;
    _insertTime = DateTime.fromMillisecondsSinceEpoch((map[TaskGen.COLUMN_INSERTTIME]??0) as int);
    _updateTime = DateTime.fromMillisecondsSinceEpoch((map[TaskGen.COLUMN_UPDATETIME]??0) as int);



    return result; 

  }



}