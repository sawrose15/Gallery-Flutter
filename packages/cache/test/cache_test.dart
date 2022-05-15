import 'package:cache/cache.dart';
import 'package:test/test.dart';

void main() {
  group('CacheClient', () {
    test('Can read and write a value for given key', () {
      final cache = CacheClient();
      const key = '__key__';
      const value = '__value__';
      expect(cache.read(key: key), isNull);
      cache.write(key: key, value: value);
      expect(cache.read(key: key), equals(value));
    });
  });
}
