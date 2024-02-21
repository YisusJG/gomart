import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_state.dart';
import 'package:gomart/Menu/inventory/repository/inventory_repository.dart';
import 'package:gomart/Menu/sideBar/repository/side_bar_repository.dart';
import 'package:gomart/Menu/sideBar/ui/widget/side_menu_row.dart';
import '../../../inventory/bloc/api/branchInventory/branch_inventory_event.dart';
import '../../models/side_menu_item_model.dart';

class SideBarScreen extends StatefulWidget {
  const SideBarScreen({super.key});

  @override
  State<SideBarScreen> createState() => _SideBarScreenState();
}

class _SideBarScreenState extends State<SideBarScreen> {
  // final List<SideMenuItemModel> _browseMenuIcons =
  //     SideMenuItemModel.sideMenuItems;
  final List<SideMenuItemModel> _browseMenuIcons2 =
      SideMenuItemModel.sideMenuItems2;
  late String _selectedMenu = SideMenuItemModel.sideMenuItems[0].title;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => InventoryRepository(),
        ),
        RepositoryProvider(
          create: (context) => SideBarRepository(),
        )
      ],
      child: BlocProvider(create: (context) => BranchInventoryBloc(RepositoryProvider.of(context))..add(GetEmployeeInfoEvent(employeeModel: null)),
          child: BlocBuilder<BranchInventoryBloc, BranchInventoryState>(
              builder: (contextEmployee, stateEmployee) {
            if (stateEmployee is GetEmployeeInfoState) {
              print("dddd");
              return Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                constraints: const BoxConstraints(maxWidth: 240),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade800,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.7),
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.person_outline),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${stateEmployee.employeeModel!.name} ${stateEmployee.employeeModel!.lastName}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                stateEmployee.employeeModel!.employeeNumber,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 24,right: 24, top: 48, bottom: 8),
                    //   child: Text("OPCIONES",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w600
                    //     ),
                    //   ),
                    // ),
                    // for(var menu in _browseMenuIcons)...[
                    //    Divider(
                    //     color: Colors.white.withOpacity(0.4),
                    //     thickness: 1,
                    //     height: 1,
                    //     indent: 16,
                    //     endIndent: 16,
                    //   ),
                    //   Padding(padding: const EdgeInsets.only(left: 2,top: 10),
                    //     child: SideMenuRow(sideMenuItemModel: menu,selectedMenu: _selectedMenu, onMenuPress: () => onMenuPress(menu),),
                    //   )
                    // ],
                    const Spacer(),
                    for (var menu in _browseMenuIcons2) ...[
                      Divider(
                        color: Colors.white.withOpacity(0.4),
                        thickness: 1,
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, top: 10),
                        child: SideMenuRow(
                          sideMenuItemModel: menu,
                          selectedMenu: _selectedMenu,
                          onMenuPress: () => onMenuPress(menu),
                        ),
                      )
                    ]
                  ],
                ),
              );
            }
            return Container();
          })),
    );
  }

  void onMenuPress(SideMenuItemModel menu) {
    //setState(() {
    _selectedMenu = menu.title;
    debugPrint("entra scree");
    //});
  }
}
