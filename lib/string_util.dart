// input: [ atoms ]
// output: atoms
String extractSectionAndFormatAndWrite(String input) {
  var extracted = input.replaceAll('[', '').replaceAll(']', '').trim();
  return extracted.toLowerCase();
}

// input :   1  C  1  URE      C      1     0.880229  12.01000   ; amber C  type
// return:["   1","  C", "  1", "  URE"....]
// 逐个字符读取，首次读到空格继续，当遇到非空格字符以后，再遇到空格添加前面读的东西到列表
List<String> processString(String input) {
  List<String> resultList = [];
  String currentWord = '';
  bool hasMeetStr = false;

  for (int i = 0; i < input.length; i++) {
    String currentChar = input[i];
    if (currentChar == ' ' && hasMeetStr){
      resultList.add(currentWord);
      currentWord = ' ';
      hasMeetStr = false;
      continue;
    }
    currentWord += currentChar;
    hasMeetStr = (currentChar != ' ');
  }
  if (input == "") {
    resultList.add("");
    return resultList;
  }

  resultList.add(currentWord);

  return resultList;
}
