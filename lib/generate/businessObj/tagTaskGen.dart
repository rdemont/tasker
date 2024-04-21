import '../databaseObj/tagTaskDBGen.dart';
import '../../businessObj/tagTask.dart';
import '../../businessObj/businessObj.dart';
import '../../businessObj/tag.dart';
import '../../businessObj/task.dart';


class TagTaskGen extends BusinessObj
{
  TagTaskDBGen get _localDbObj => dbObj as TagTaskDBGen ;

  TagTaskGen(super.dbObj);

  static const String TABLE_NAME = "tagTask";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TAGID = "tagId";
  static const String COLUMN_TASKID = "taskId";



  Tag get tag => _localDbObj.tag;
  int get tagId => _localDbObj.tagId;
  Task get task => _localDbObj.task;
  int get taskId => _localDbObj.taskId;


  set tag(Tag value)
  {
    _localDbObj.tag = value;
  }
  set task(Task value)
  {
    _localDbObj.task = value;
  }


  static TagTask newObj(){
    TagTaskDBGen objDb = TagTaskDBGen();
    return objDb.newObj();
  }

  static Future<TagTask> openObj(int id){
    TagTaskDBGen objDb = TagTaskDBGen();
    return objDb.open(id);
  }

  static Future<TagTask> fromMap(Map<String,Object?>map){
    TagTaskDBGen objDb = TagTaskDBGen();
    return objDb.fromMap(map);
  }

  @override
  TagTask clone() {
    TagTask result = TagTaskGen.newObj(); 

    super.cloneDB(result._localDbObj);
    
    return result ; 
  }

}