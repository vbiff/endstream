import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app_database.dart';

/// Constructs the platform-appropriate database connection.
AppDatabase constructDb() {
  final db = LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'endstream_cache.db'));
    return NativeDatabase.createInBackground(file);
  });
  return AppDatabase(db);
}
