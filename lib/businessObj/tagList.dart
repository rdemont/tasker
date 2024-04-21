import 'tag.dart';
import '../generate/businessObj/tagListGen.dart';



class TagList extends TagListGen
{

  static Future<List<Tag>> getAll([String? order]){
    return TagListGen.getAll(order);
  }
}