import 'package:change_top/index_map_single.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {

  test("test1", () {
    IndexMapSingleton().generateDelSet(1, 3);
    expect(IndexMapSingleton().delIndexSet, {1, 2, 3});
  });

  test("csvRead", () async {
    await IndexMapSingleton().setIndexMapByCsv("test/demo.csv");
    expect(IndexMapSingleton().indexMap, {1:9, 2:10});
  });
}
