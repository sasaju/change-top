import 'dart:convert';
import 'dart:developer';

import 'package:change_top/string_util.dart';
import 'package:change_top/topfile_util.dart';

Future<void> changeTopByIndex(
  String topFilePath,
  String outputFilePath,
) async {
  var fileStr = await readFileAsString(topFilePath);
  var lines = LineSplitter().convert(fileStr);
  var nowSection = "";
  for (var line in lines) {
    if (!appendToFileIfStartsWithSpecialChar(line, outFilePath: outputFilePath)) {
      var firstChar = line.isNotEmpty ? line[0] : '';
      if (firstChar == "[") {
        nowSection = extractSectionAndFormatAndWrite(line);
        writeStringToFile(line, outFilePath: outputFilePath);
        continue;
      } else {
        changeTopByIndexAndWrite(line, nowSection, outFilePath: outputFilePath);
        continue;
      }
    }
  }
}

Future<void> delTopByIndex(String topFilePath, String outputFilePath) async {
  var a = await readFileAsString(topFilePath);
  var lines = LineSplitter().convert(a);
  var nowSection = "";
  for (var line in lines) {
    if (!appendToFileIfStartsWithSpecialChar(line, outFilePath: outputFilePath)) {
      var firstChar = line.isNotEmpty ? line[0] : '';
      if (firstChar == "[") {
        nowSection = extractSectionAndFormatAndWrite(line);
        writeStringToFile(line, outFilePath: outputFilePath);
        continue;
      } else {
        if (!needDel(line, nowSection)) {
          writeStringToFile(line, outFilePath: outputFilePath);
          continue;
        }
      }
    }
  }
}

Future<void> extractTopByIndex(String topFilePath, String outputFilePath) async {
  var a = await readFileAsString(topFilePath);
  var lines = LineSplitter().convert(a);
  var nowSection = "";
  for (var line in lines) {
    if (!appendToFileIfStartsWithSpecialChar(line, outFilePath: outputFilePath)) {
      var firstChar = line.isNotEmpty ? line[0] : '';
      if (firstChar == "[") {
        nowSection = extractSectionAndFormatAndWrite(line);
        writeStringToFile(line, outFilePath: outputFilePath);
        continue;
      } else {
        if (needSave(line, nowSection)) {
          writeStringToFile(line, outFilePath: outputFilePath);
          continue;
        }
      }
    }
    // else{
    //   writeStringToFile(line, outFilePath: outputFilePath);
    //   return;
    // }
  }
}
