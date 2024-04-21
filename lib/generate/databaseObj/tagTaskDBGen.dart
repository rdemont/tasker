import '../../businessObj/tagTask.dart';
import '../businessObj/tagTaskGen.dart';
import '../../databaseObj/databaseObj.dart';
import '../../businessObj/tag.dart';
import '../businessObj/tagGen.dart';
import '../../businessObj/task.dart';
import '../businessObj/taskGen.dart';


class TagTaskDBGen extends DatabaseObj {
  
  Tag _tag = TagGen.newObj();
  int _tagId = 0;
  Task _task = TaskGen.newObj();
  int _taskId = 0;



  TagTaskDBGen()
  {
    tableName = 'tagTask';
  }

  Tag get tag => _tag;
  int get tagId => _tagId;
  Task get task => _task;
  int get taskId => _taskId;



  set tag(Tag value)
  {
    if (_tagId != value.id)
    {
      dataUpdated(); 
      _tagId = value.id;
      _tag = value;
    }
  }
  set task(Task value)
  {
    if (_taskId != value.id)
    {
      dataUpdated(); 
      _taskId = value.id;
      _task = value;
    }
  }


  Future<TagTask> open(int id)
  {
    return query(TagTaskGen.TABLE_NAME,where: TagTaskGen.COLUMN_ID+" = $id").then((obj)
    {
      TagTask result = TagTask(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);
        TagGen.openObj(_tagId).then((value){
          _tag = value ;
        });
        TaskGen.openObj(_taskId).then((value){
          _task = value ;
        });

      }
      return result ; 
    });
  }

  TagTask newObj()
  {
    TagTask result = TagTask(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    return{
      TagTaskGen.COLUMN_TAGID : _tagId,
      TagTaskGen.COLUMN_TASKID : _taskId,

    };
    
  }


  Future<TagTask> fromMap(Map<String,Object?> map)
  async {
    TagTask result = TagTask(this) ;
    super.id = map[TagTaskGen.COLUMN_ID] as int; 
    
    _tagId = (map[TagTaskGen.COLUMN_TAGID]??0) as int;
    if (_tagId >0 )
    {
      _tag = await TagGen.openObj(_tagId);
    }
    _taskId = (map[TagTaskGen.COLUMN_TASKID]??0) as int;
    if (_taskId >0 )
    {
      _task = await TaskGen.openObj(_taskId);
    }



    return result; 

  }

 
  @override
  clone(DatabaseObj value)
  {
    super.clone(value);
    (value as TagTaskDBGen)._tagId = tagId;
    (value as TagTaskDBGen)._taskId = taskId;

  }
}