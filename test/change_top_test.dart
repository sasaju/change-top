import 'dart:convert';
import 'dart:io';

import 'package:change_top/topfile_util.dart';
import 'package:change_top/index_map_single.dart';
import 'package:change_top/string_util.dart';
import 'package:test/test.dart';

void main() {
  test('read_top', () async {
    var content = await readFileAsString("test/test.txt");
    expect(content, "123");
  });

  test("changeTopIndex", () async {
    var a = await readFileAsString("test/demo.top");
    var lines = LineSplitter().convert(a);
    var nowSection = "";
    for (var line in lines) {
      if (!appendToFileIfStartsWithSpecialChar(line)) {
        var firstChar = line.isNotEmpty ? line[0] : '';
        if (firstChar == "[") {
          nowSection = extractSectionAndFormatAndWrite(line);
          writeStringToFile(line);
        } else {
          final a = IndexMapSingleton();
          a.indexMap = {2: 25};
          changeTopByIndexAndWrite(line, nowSection);
        }
      }
    }
  });

    test("delByIndex", () async {
      IndexMapSingleton().generateDelSet(1, 3);
      var a = await readFileAsString("test/demo.top");
      var lines = LineSplitter().convert(a);
      var nowSection = "";
      for (var line in lines) {
        if (!appendToFileIfStartsWithSpecialChar(line)) {
          var firstChar = line.isNotEmpty ? line[0] : '';
          if (firstChar == "[") {
            nowSection = extractSectionAndFormatAndWrite(line);
            writeStringToFile(line);
          } else {
            if (!needDel(line, nowSection)){
              writeStringToFile(line);
            }
          }
        }
      }
      expect(IndexMapSingleton().delIndexSet, {1,2,3});
      writeStringToFile("", mode: FileMode.writeOnly);
    });
}
