import 'tag.dart';
import '../generate/businessObj/tagListGen.dart';



class TagList extends TagListGen
{

  static Future<List<Tag>> getAll([String? order]){
    return TagListGen.getAll(order:order);
  }


  static Future<List<Tag>> getQuery({String? order, String? where}){
    return TagListGen.getQuery(order:order,where:where);
    
  }  
}