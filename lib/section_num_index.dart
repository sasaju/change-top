import 'package:change_top/index_map_single.dart';
import 'package:change_top/string_util.dart';

class AtomsSec extends Section{
  AtomsSec({required super.content}) : super(indexCol: [0,5]);
}

class BondsSec extends Section{
  BondsSec({required super.content}) : super(indexCol: [0,1]);
}

class DihedralsSec extends Section{
  DihedralsSec({required super.content}) : super(indexCol: [0,1,2,3]);
}

class PositionRestraintsSec extends Section{
  PositionRestraintsSec({required super.content}) : super(indexCol: [0,]);
}

class DihedralRestraintsSec extends Section{
  DihedralRestraintsSec({required super.content}) : super(indexCol: [0,1,2,3]);
}


abstract class Section{
  late String content;
  late List<int> indexCol;
  Section({required this.content, required this.indexCol});

  void setContentToChangeByIndex() {
    final contentStringList = processString(content);
    if(contentStringList.length==1){
      content = "";
      return;
    }
    for (var index in indexCol){
      final oldChar = contentStringList[index];
      final oldIndex = int.parse(oldChar);
      final oldCharLen = oldChar.length;
      final newIndexOrNull = IndexMapSingleton().indexMap[oldIndex];
      final newIndex = (newIndexOrNull != null)? newIndexOrNull: oldIndex;
      contentStringList[index] = newIndex.toString().padLeft(oldCharLen);
    }
    content = contentStringList.join("");
  }

  bool contentNeedDel(){
    if (content==""){
      return false;
    }
    final delMap = IndexMapSingleton().delIndexSet;
    final Set<int> nowMap = {};
    for (var index in indexCol){
      final contentStringList = processString(content);
      final nowChar = contentStringList[index];
      final nowIndex = int.parse(nowChar);
      nowMap.add(nowIndex);
    }
    return delMap.intersection(nowMap).isNotEmpty;
  }

  bool contentNeedSave(){
    if (content==""){
      return true;
    }
    final saveMap = IndexMapSingleton().saveIndexSet;
    final Set<int> nowMap = {};
    for (var index in indexCol){
      final contentStringList = processString(content);
      final nowChar = contentStringList[index];
      final nowIndex = int.parse(nowChar);
      nowMap.add(nowIndex);
    }
    return saveMap.intersection(nowMap).isNotEmpty;
  }
  
  @override
  String toString() {
    return content;
  }

}