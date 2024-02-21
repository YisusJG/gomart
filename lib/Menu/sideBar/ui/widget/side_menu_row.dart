import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/sideBar/bloc/local/deleteDatabase/delete_database_bloc.dart';
import 'package:gomart/Menu/sideBar/bloc/local/deleteDatabase/delete_database_state.dart';
import 'package:gomart/Menu/sideBar/models/side_menu_item_model.dart';
import '../../../../ConnectionToGomart/ui/screen/connection_to_gomart_screen.dart';
import '../../bloc/local/deleteDatabase/delete_database_event.dart';
import '../../repository/side_bar_repository.dart';

class SideMenuRow extends StatelessWidget {
  //final BuildContext context;
  final SideMenuItemModel sideMenuItemModel;
  final String selectedMenu;
  final Function? onMenuPress;
  const SideMenuRow({super.key, required this.sideMenuItemModel, this.selectedMenu = "Inicio", this.onMenuPress});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteDatabaseBloc>(create: (context) => DeleteDatabaseBloc(RepositoryProvider.of<SideBarRepository>(context)),
      child: BlocBuilder<DeleteDatabaseBloc,DeleteDatabaseState>(builder: (contextDelete,stateDelete){
        return BlocListener<DeleteDatabaseBloc,DeleteDatabaseState>(listener: (contextDeleteDataBase,stateDeleteDataBase){
          debugPrint("entraaa listener");
          if(stateDeleteDataBase is DeleteLocalDatabaseState){
            debugPrint("Se elimino la base");
            messagesSnackBar(contextDelete, "Datos eliminados");
            Navigator.push(contextDeleteDataBase, MaterialPageRoute(builder: (_) => const ConnectionToGomartScreen ()));
          }
        },
          child: Stack(
            children: [
              AnimatedContainer(duration: const Duration(milliseconds: 300),
                width: selectedMenu == sideMenuItemModel.title ? 288 - 16 : 0,
                height: 36,
                decoration:  BoxDecoration(color: Colors.cyan,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              InkWell(
                onTap: (){
                  onMenuPressed(contextDelete);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 62,
                      height: 32,
                      child: Opacity(opacity: 0.7,
                        child: Icon(sideMenuItemModel.icon,color: Colors.white,size: 30,),
                      ),
                    ),
                    Text(sideMenuItemModel.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      })
    );
  }

  void onMenuPressed(BuildContext contextDelete){
    debugPrint("entra");
    contextDelete.read<DeleteDatabaseBloc>().add(DeleteLocalDatabaseEvent());
    //Navigator.push(contextDelete, MaterialPageRoute(builder: (_) => const ConnectionToGomartScreen()));
    onMenuPress!();
  }

  void messagesSnackBar(BuildContext contextDelete,String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(contextDelete).showSnackBar(snackBar);
  }
}
