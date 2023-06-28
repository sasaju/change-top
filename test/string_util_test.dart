import 'package:change_top/string_util.dart';
import 'package:test/test.dart';

void main() {
  test('read_top', () {
    var content = processString("   1  C  1  URE      C      1     0.880229  12.01000   ; amber C  type");
    print(content);
    expect(content[0], "   1");
    expect(content[1], "  C");
  });
}
