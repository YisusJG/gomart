


import 'gomart_db.dart';

class DB {
  /// Contructor privado para DB
  DB._internal();

  static final DB _db = DB._internal();

  /// Creamos una instancia del constuctor privado DB
  static DB get instance => _db;
  static AppDatabase? _database;

  /// Creamos la funcion que valida si la instancia de _database ya fue creada o no
  Future<AppDatabase?> get database async {
    if (_database != null) return _database;
    _database = await $FloorAppDatabase.databaseBuilder('gomart.db').build();
    return _database;
  }
}