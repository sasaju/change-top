import 'package:change_top/index_map_single.dart';
import 'package:change_top/section_num_index.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main(){
  test("testAtom1", () {
    var as = AtomsSec(content: "   2  O  1  URE      O      2    -0.613359  16.00000   ; amber O  type");
    final a = IndexMapSingleton();
    a.indexMap = {2:5};
    as.setContentToChangeByIndex();
    expect(as.toString(), "   5  O  1  URE      O      5    -0.613359  16.00000   ; amber O  type");
  });
  test("testAtom2", () {
    var as = AtomsSec(content: "   2  O  1  URE      O      2    -0.613359  16.00000   ; amber O  type");
    final a = IndexMapSingleton();
    a.indexMap = {2:25};
    as.setContentToChangeByIndex();
    expect(as.toString(), "  25  O  1  URE      O     25    -0.613359  16.00000   ; amber O  type");
  });
}