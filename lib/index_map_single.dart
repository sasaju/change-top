import 'dart:io';

import 'package:csv/csv.dart';
class IndexMapSingleton {
  static final IndexMapSingleton _instance = IndexMapSingleton._internal();

  factory IndexMapSingleton() {
    return _instance;
  }

  IndexMapSingleton._internal();

  Map<int, int> indexMap = {};
  Set<int> delIndexSet = {};
  Set<int> saveIndexSet = {};

  void setIndexMapByFunc(int start,int end, {int addIndex = 0}) {
    indexMap.clear();
    for (int i = start; i <= end; i++) {
      indexMap[i] = i+addIndex;
    }
  }
  
  Future<void> setIndexMapByCsv(
      String csvFilePath,
      ) async {
    indexMap.clear();
    // 读取CSV文件
    final file = File(csvFilePath);
    final csvString = await file.readAsString();
    // 解析CSV数据
    final csvParser = CsvToListConverter();
    final List<List<dynamic>> csvList = csvParser.convert(csvString);

    // 转换为Map
    for (var i = 0; i < csvList.length; i++) {
      final row = csvList[i];
      final key = row[0] as int;
      final value = row[1] as int;
      indexMap[key] = value;
    }
  }

  void generateDelSet(int start, int end) {
    delIndexSet.clear();
    for (int i = start; i <= end; i++) {
      delIndexSet.add(i);
    }
  }

  void generateSaveSet(int start, int end) {
    saveIndexSet.clear();
    for (int i = start; i <= end; i++) {
      saveIndexSet.add(i);
    }
  }
}
