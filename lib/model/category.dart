import 'package:drift/drift.dart';

class CategoryTable extends Table {
  /// 식별 가능한 ID
  IntColumn get id => integer().autoIncrement()();

  /// 카테고리
  TextColumn get color => text()();

  /// 일정 생성날짜시간
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now().toUtc(),
      )();
}
