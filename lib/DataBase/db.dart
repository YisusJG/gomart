
import 'dart:io';
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

  /// Método para eliminar la base de datos y el archivo asociado
  Future<bool> deleteDatabase() async {
    try {
      const dbPath = '/data/user/0/com.gomart.gomart/databases/gomart.db';
      await _database?.close(); // Cerrar la base de datos antes de eliminarla
      _database = null; // Limpiar la referencia a la base de datos
      await File(dbPath).delete(); // Eliminar el archivo de la base de datos
      return true; // Devolver true si se eliminó correctamente
    } catch (e) {
      print('Error al eliminar la base de datos: $e');
      return false; // Devolver false si ocurrió algún error al eliminar la base de datos
    }
  }
}