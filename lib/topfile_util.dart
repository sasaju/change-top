import 'dart:io';

import 'package:change_top/section_num_index.dart';

Future<String> readFileAsString(String filePath) async {
  var file = File(filePath);
  if (!await file.exists()) {
    throw Exception('File not found: $filePath');
  }

  var contents = await file.readAsString();
  return contents;
}

bool appendToFileIfStartsWithSpecialChar(String text,
    {String outFilePath = "test/test_out.txt"}) {
  var specialChars = ['#', ';'];
  var firstChar = text.isNotEmpty ? text[0] : '';

  if (specialChars.contains(firstChar)) {
    var file = File(outFilePath);
    file.writeAsStringSync("$text\n", mode: FileMode.append);
    return true;
  } else {
    return false;
  }
}

void writeStringToFile(String text,
    {String outFilePath = "test/test_out.txt", FileMode mode = FileMode.append}) {
  var file = File(outFilePath);
  file.writeAsStringSync("$text\n", mode: mode);
}



void changeTopByIndexAndWrite(String text, String section,
    {String outFilePath = "test/test_out.txt"}) {
  const handleList = [
    "atoms",
    "bonds",
    "dihedrals",
    "position_restraints",
    "dihedral_restraints"
  ];
  if (handleList.contains(section)) {
    var newText = "";
    switch (section) {
      case "atoms":
        final atom = AtomsSec(content: text);
        atom.setContentToChangeByIndex();
        newText = atom.toString();
      case "bonds":
        final bond = BondsSec(content: text);
        bond.setContentToChangeByIndex();
        newText = bond.toString();
      case "dihedrals":
        final dihedral = DihedralsSec(content: text);
        dihedral.setContentToChangeByIndex();
        newText = dihedral.toString();
      case "position_restraints":
        final positionRestraint = PositionRestraintsSec(content: text);
        positionRestraint.setContentToChangeByIndex();
        newText = positionRestraint.toString();
      case "dihedral_restraints":
        final dihedralRestraint = DihedralRestraintsSec(content: text);
        dihedralRestraint.setContentToChangeByIndex();
        newText = dihedralRestraint.toString();
    }
    writeStringToFile(newText, outFilePath: outFilePath);
  } else {
    writeStringToFile(text, outFilePath: outFilePath);
  }
}

bool needDel(String text, String section,
    {String outFilePath = "test/test_out.txt"}) {
  const handleList = [
    "atoms",
    "bonds",
    "dihedrals",
    "position_restraints",
    "dihedral_restraints"
  ];
  if (handleList.contains(section)) {
    switch (section) {
      case "atoms":
        final atom = AtomsSec(content: text);
        return atom.contentNeedDel();
      case "bonds":
        final bond = BondsSec(content: text);
        return bond.contentNeedDel();
      case "dihedrals":
        final dihedral = DihedralsSec(content: text);
        return dihedral.contentNeedDel();
      case "position_restraints":
        final positionRestraint = PositionRestraintsSec(content: text);
        return positionRestraint.contentNeedDel();
      case "dihedral_restraints":
        final dihedralRestraint = DihedralRestraintsSec(content: text);
        return dihedralRestraint.contentNeedDel();
    }
  }
  return false;
}

bool needSave(String text, String section,
    {String outFilePath = "test/test_out.txt"}) {
  const handleList = [
    "atoms",
    "bonds",
    "dihedrals",
    "position_restraints",
    "dihedral_restraints"
  ];
  if (handleList.contains(section)) {
    switch (section) {
      case "atoms":
        final atom = AtomsSec(content: text);
        return atom.contentNeedSave();
      case "bonds":
        final bond = BondsSec(content: text);
        return bond.contentNeedSave();
      case "dihedrals":
        final dihedral = DihedralsSec(content: text);
        return dihedral.contentNeedSave();
      case "position_restraints":
        final positionRestraint = PositionRestraintsSec(content: text);
        return positionRestraint.contentNeedSave();
      case "dihedral_restraints":
        final dihedralRestraint = DihedralRestraintsSec(content: text);
        return dihedralRestraint.contentNeedSave();
    }
  }
  return false;
}