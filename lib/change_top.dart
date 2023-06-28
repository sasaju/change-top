import 'dart:convert';

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
    if (!appendToFileIfStartsWithSpecialChar(line)) {
      var firstChar = line.isNotEmpty ? line[0] : '';
      if (firstChar == "[") {
        nowSection = extractSectionAndFormatAndWrite(line);
        writeStringToFile(line, outFilePath: outputFilePath);
      } else {
        changeTopByIndexAndWrite(line, nowSection, outFilePath: outputFilePath);
      }
    }else{
      writeStringToFile(line, outFilePath: outputFilePath);
    }
  }
}

Future<void> delTopByIndex(String topFilePath, String outputFilePath) async {
  var a = await readFileAsString(topFilePath);
  var lines = LineSplitter().convert(a);
  var nowSection = "";
  for (var line in lines) {
    if (!appendToFileIfStartsWithSpecialChar(line)) {
      var firstChar = line.isNotEmpty ? line[0] : '';
      if (firstChar == "[") {
        nowSection = extractSectionAndFormatAndWrite(line);
        writeStringToFile(line, outFilePath: outputFilePath);
      } else {
        if (!needDel(line, nowSection)) {
          writeStringToFile(line, outFilePath: outputFilePath);
        }
      }
    }else{
      writeStringToFile(line, outFilePath: outputFilePath);
    }
  }
}

Future<void> extractTopByIndex(String topFilePath, String outputFilePath) async {
  var a = await readFileAsString(topFilePath);
  var lines = LineSplitter().convert(a);
  var nowSection = "";
  for (var line in lines) {
    if (!appendToFileIfStartsWithSpecialChar(line)) {
      var firstChar = line.isNotEmpty ? line[0] : '';
      if (firstChar == "[") {
        nowSection = extractSectionAndFormatAndWrite(line);
        writeStringToFile(line, outFilePath: outputFilePath);
      } else {
        if (needSave(line, nowSection)) {
          writeStringToFile(line, outFilePath: outputFilePath);
        }
      }
    }else{
      writeStringToFile(line, outFilePath: outputFilePath);
    }
  }
}
