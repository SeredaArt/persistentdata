import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'users.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  TextColumn get lastname => text().withLength(min: 1, max: 32)();
  IntColumn get years => integer()();
  TextColumn get image => text()();
  TextColumn  get phone => text()();
  TextColumn  get card => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Users])
class MyDataBase extends _$MyDataBase {
  MyDataBase() : super(_openConnection());

  Future<List<User>> get allUserEntries => select(users).get();
  Future<int> insertUser(user) => into(users).insert(user);
  Stream<List<User>> usersStream() => select(users).watch();
  Future<bool> updateUser(User user) => update(users).replace(user);
  Future<int> deleteUser(int id) =>
      (delete(users)..where((u) => u.id.equals(id))).go();

  Future<void> deleteEverything() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }

  @override
  int get schemaVersion => 1;
}
