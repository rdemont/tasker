import '../../businessObj/tag.dart';
import '../businessObj/tagGen.dart';
import '../../databaseObj/databaseObj.dart';


class TagDBGen extends DatabaseObj {
  
  String _name = '';
  DateTime _insertTime = DateTime.now();
  DateTime _updateTime = DateTime.now();



  TagDBGen()
  {
    tableName = 'tag';
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


  Future<Tag> open(int id)
  {
    return query(TagGen.TABLE_NAME,where: TagGen.COLUMN_ID+" = $id").then((obj)
    {
      Tag result = Tag(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);

      }
      return result ; 
    });
  }

  Tag newObj()
  {
    Tag result = Tag(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    return{
      TagGen.COLUMN_NAME : _name,
      TagGen.COLUMN_INSERTTIME : _insertTime.millisecondsSinceEpoch,
      TagGen.COLUMN_UPDATETIME : _updateTime.millisecondsSinceEpoch,

    };
    
  }


  Future<Tag> fromMap(Map<String,Object?> map)
  async {
    Tag result = Tag(this) ;
    super.id = map[TagGen.COLUMN_ID] as int; 
    
    _name = (map[TagGen.COLUMN_NAME]??'') as String;
    _insertTime = DateTime.fromMillisecondsSinceEpoch((map[TagGen.COLUMN_INSERTTIME]??0) as int);
    _updateTime = DateTime.fromMillisecondsSinceEpoch((map[TagGen.COLUMN_UPDATETIME]??0) as int);



    return result; 

  }

 
  @override
  clone(DatabaseObj value)
  {
    super.clone(value);
    (value as TagDBGen)._name = name;
    (value as TagDBGen)._insertTime = insertTime;
    (value as TagDBGen)._updateTime = updateTime;

  }
}