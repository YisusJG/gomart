// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gomart_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EmployeeDao? _employeeDaoInstance;

  BranchDao? _branchDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EmployeeEntity` (`id` INTEGER NOT NULL, `employeeNumber` TEXT NOT NULL, `name` TEXT NOT NULL, `lastName` TEXT NOT NULL, `mothersLastName` TEXT NOT NULL, `photo` TEXT, `corporateEmail` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BranchEntity` (`id` INTEGER NOT NULL, `zoneName` TEXT NOT NULL, `branchNumber` TEXT NOT NULL, `ip` TEXT NOT NULL, `description` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EmployeeDao get employeeDao {
    return _employeeDaoInstance ??= _$EmployeeDao(database, changeListener);
  }

  @override
  BranchDao get branchDao {
    return _branchDaoInstance ??= _$BranchDao(database, changeListener);
  }
}

class _$EmployeeDao extends EmployeeDao {
  _$EmployeeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _employeeEntityInsertionAdapter = InsertionAdapter(
            database,
            'EmployeeEntity',
            (EmployeeEntity item) => <String, Object?>{
                  'id': item.id,
                  'employeeNumber': item.employeeNumber,
                  'name': item.name,
                  'lastName': item.lastName,
                  'mothersLastName': item.mothersLastName,
                  'photo': item.photo,
                  'corporateEmail': item.corporateEmail
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EmployeeEntity> _employeeEntityInsertionAdapter;

  @override
  Future<List<EmployeeEntity>> findAllEmployee() async {
    return _queryAdapter.queryList('SELECT * FROM EmployeeEntity',
        mapper: (Map<String, Object?> row) => EmployeeEntity(
            id: row['id'] as int,
            employeeNumber: row['employeeNumber'] as String,
            name: row['name'] as String,
            lastName: row['lastName'] as String,
            mothersLastName: row['mothersLastName'] as String,
            photo: row['photo'] as String?,
            corporateEmail: row['corporateEmail'] as String));
  }

  @override
  Future<EmployeeEntity?> deleteEmployee() async {
    return _queryAdapter.query('DELETE FROM EmployeeEntity',
        mapper: (Map<String, Object?> row) => EmployeeEntity(
            id: row['id'] as int,
            employeeNumber: row['employeeNumber'] as String,
            name: row['name'] as String,
            lastName: row['lastName'] as String,
            mothersLastName: row['mothersLastName'] as String,
            photo: row['photo'] as String?,
            corporateEmail: row['corporateEmail'] as String));
  }

  @override
  Future<void> insertEmployee(EmployeeEntity employee) async {
    await _employeeEntityInsertionAdapter.insert(
        employee, OnConflictStrategy.abort);
  }
}

class _$BranchDao extends BranchDao {
  _$BranchDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _branchEntityInsertionAdapter = InsertionAdapter(
            database,
            'BranchEntity',
            (BranchEntity item) => <String, Object?>{
                  'id': item.id,
                  'zoneName': item.zoneName,
                  'branchNumber': item.branchNumber,
                  'ip': item.ip,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BranchEntity> _branchEntityInsertionAdapter;

  @override
  Future<List<BranchEntity>> findAllBranch() async {
    return _queryAdapter.queryList('SELECT * FROM BranchEntity',
        mapper: (Map<String, Object?> row) => BranchEntity(
            id: row['id'] as int,
            zoneName: row['zoneName'] as String,
            branchNumber: row['branchNumber'] as String,
            ip: row['ip'] as String,
            description: row['description'] as String));
  }

  @override
  Future<BranchEntity?> deleteBranch() async {
    return _queryAdapter.query('DELETE FROM BranchEntity',
        mapper: (Map<String, Object?> row) => BranchEntity(
            id: row['id'] as int,
            zoneName: row['zoneName'] as String,
            branchNumber: row['branchNumber'] as String,
            ip: row['ip'] as String,
            description: row['description'] as String));
  }

  @override
  Future<void> insertBranch(BranchEntity branch) async {
    await _branchEntityInsertionAdapter.insert(
        branch, OnConflictStrategy.abort);
  }
}
