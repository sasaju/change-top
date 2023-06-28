import 'package:args/args.dart';

bool checkArgsParsed(ArgParser parser,ArgResults results, List<String> requiredOptions){
  final List<String> missingOptions = [];
  final abbrMap = {
    "csv":"c",
    "top":"p",
    "out":"o",
    "start":"s",
    "end":"e"
  };
  for (final option in requiredOptions) {
    var abbr = abbrMap[option];
    abbr ??= "";
    if (!(wasParsedCustom(results, option) || wasParsedCustom(results,abbr))) {
      missingOptions.add("-$option(-$abbr)");
    }
  }
  if (missingOptions.isNotEmpty) {
    print('Missing options: ${missingOptions.join(', ')}');
    return false;
  } else {
    return true;
  }
}

bool wasParsedCustom(ArgResults results, String requiredOption){
  try{
    return results.command![requiredOption] != null;
  }on ArgumentError{
    return false;
  }
}
