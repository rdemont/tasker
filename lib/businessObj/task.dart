
import 'package:tasker/generate/businessObj/tagTaskGen.dart';

import '../generate/businessObj/taskGen.dart';
import 'tag.dart';
import 'tagTask.dart';
import 'tagTaskList.dart';

class Task extends TaskGen
{
  Task(super.dbObj);

  

  Future<List<TagTask>> getTagTaskList()
  {
    return TagTaskList.getQuery(where : "${TagTaskGen.COLUMN_TASKID} = $id").then((value) {
      return value; 
    });
  }

  Future<List<Tag>> getTags()
  {

    return TagTaskList.getQuery(where : "${TagTaskGen.COLUMN_TASKID} = $id").then((value) {
      List<Tag> result = [] ; 
      for (TagTask tt in value)
      {
        result.add(tt.tag);
      }
      return result ; 
    });
  }

}