import '../generate/businessObj/tagGen.dart';

class Tag extends TagGen
{
  Tag(super.dbObj);


  @override
  bool operator ==(Object other) {
    if (other is String) return name.toUpperCase() == other.toUpperCase();
    if (!(other is Tag)) return false ; 
    if (identical(this, other)) {
      return true;
    }
    return name.toUpperCase() == other.name.toUpperCase();
  }

}