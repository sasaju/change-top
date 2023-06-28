import 'package:args/args.dart';
import 'package:change_top/change_top.dart' as change_top;
import 'package:change_top/index_map_single.dart';

import 'cli_util.dart';

Future<void> main(List<String> arguments) async {
  var parser = ArgParser();

  // cgtop change
  var changeCommand = parser.addCommand("change");
  changeCommand.addOption("csv", abbr: "c");
  changeCommand.addOption("top", abbr: "p");
  changeCommand.addOption("out", abbr: "o");

  // cgtop del
  var delCommand = parser.addCommand("del");
  delCommand.addOption("top", abbr: "p");
  delCommand.addOption("out", abbr: "o");
  delCommand.addOption("start", abbr: "s");
  delCommand.addOption("end", abbr: "e");

  // cgtop extra
  var extraCommand = parser.addCommand("extra");
  extraCommand.addOption("top", abbr: "p");
  extraCommand.addOption("out", abbr: "o");
  extraCommand.addOption("start", abbr: "s");
  extraCommand.addOption("end", abbr: "e");

  var results = parser.parse(arguments);
  if(results.command==null){
    print("missing command change/del/extra");
    return;
  }
  // print(results.command!.arguments);
  switch(results.command!.name){
    case "change":
      if(!checkArgsParsed(parser, results, ["csv", "top","out"])){return;}
      IndexMapSingleton().setIndexMapByCsv(results.command!["csv"]);
      await change_top.changeTopByIndex(results.command!["top"], results.command!["out"]);
    case "del":
      if(!checkArgsParsed(parser, results, ["top", "out", "start", "end"])){return;}
      IndexMapSingleton().generateDelSet(int.parse(results.command!["start"]), int.parse(results.command!["end"]));
      await change_top.delTopByIndex(results.command!["top"], results.command!["out"]);
    case "extra":
      if(!checkArgsParsed(parser, results, ["top", "out", "start", "end"])){return;}
      IndexMapSingleton().generateSaveSet(int.parse(results.command!["start"]), int.parse(results.command!["end"]));
      await change_top.extractTopByIndex(results.command!["top"], results.command!["out"]);
    default:
      print("cgtop：Invalid command.无效指令。");
  }
}
