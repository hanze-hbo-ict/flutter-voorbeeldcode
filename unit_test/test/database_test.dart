import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:unit_test/datadase.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

void main() {
  sqfliteTestInit();
  late Database db;
  const Dog testDog = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  setUp(() async {
    db = await openDatabase(inMemoryDatabasePath);
    await db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
  });

  test('Test insertDog function', () async {
    var result = await dogs(db);
    expect(result.isEmpty, true);

    await insertDog(db, testDog);
    result = await dogs(db);

    expect(result.isEmpty, false);
  });

  test('Test equality of two objects', () async {
    await insertDog(db, testDog);
    var result = await dogs(db);
    expect(result, [testDog]);
  });

  tearDown(() async {
    await db.close();
  });
}
