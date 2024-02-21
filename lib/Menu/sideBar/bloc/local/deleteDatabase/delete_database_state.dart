class DeleteDatabaseState{
  bool isDetele;

  DeleteDatabaseState({
    this.isDetele = false,
  });
}

class DeleteLocalDatabaseState extends DeleteDatabaseState{
  DeleteLocalDatabaseState({required super.isDetele});
}