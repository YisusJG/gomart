import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/sideBar/bloc/local/deleteDatabase/delete_database_event.dart';
import 'package:gomart/Menu/sideBar/bloc/local/deleteDatabase/delete_database_state.dart';
import 'package:gomart/Menu/sideBar/repository/side_bar_repository.dart';

class DeleteDatabaseBloc extends Bloc<DeleteDataBaseEvent,DeleteDatabaseState>{
  final SideBarRepository sideBarRepository;

  DeleteDatabaseBloc(this.sideBarRepository) : super(DeleteDatabaseState()){
    on<DeleteLocalDatabaseEvent>(_deleteLocalDatabaseEvent);
  }

  void _deleteLocalDatabaseEvent(DeleteLocalDatabaseEvent event, Emitter<DeleteDatabaseState> emit) async{
    debugPrint("llega al bloc database");
    final isDeleteDataBase = await sideBarRepository.deleteDataBase();
    emit(DeleteLocalDatabaseState(isDetele: isDeleteDataBase));
  }
}