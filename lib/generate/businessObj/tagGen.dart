import '../databaseObj/tagDBGen.dart';
import '../../businessObj/tag.dart';
import '../../businessObj/businessObj.dart';


class TagGen extends BusinessObj
{
  TagDBGen get _localDbObj => dbObj as TagDBGen ;

  TagGen(super.dbObj);

  static const String TABLE_NAME = "tag";
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


  static Tag newObj(){
    TagDBGen objDb = TagDBGen();
    return objDb.newObj();
  }

  static Future<Tag> openObj(int id){
    TagDBGen objDb = TagDBGen();
    return objDb.open(id);
  }

  static Future<Tag> fromMap(Map<String,Object?>map){
    TagDBGen objDb = TagDBGen();
    return objDb.fromMap(map);
  }

  @override
  Tag clone() {
    Tag result = TagGen.newObj(); 

    super.cloneDB(result._localDbObj);
    
    return result ; 
  }

}