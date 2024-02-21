import '../../../DataBase/db.dart';

class SideBarRepository{

  Future<bool> deleteDataBase() async {
      final isDeleted = await DB.instance.deleteDatabase();
      return isDeleted;
  }
}