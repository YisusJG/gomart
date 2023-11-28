import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/ConnectionToGomart/ui/screen/connection_to_gomart_screen.dart';
import 'package:gomart/Splahs/bloc/splahsDB/splahs_local_bloc.dart';
import 'package:gomart/Splahs/bloc/splahsDB/splahs_local_state.dart';

import '../../../Menu/options/ui/screen/options_screen.dart';

class SplahsScreen extends StatefulWidget {
  const SplahsScreen({super.key});

  @override
  State<SplahsScreen> createState() => _SplahsScreenState();
}

class _SplahsScreenState extends State<SplahsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplahsLocalBloc,SplahsLocalState>(listener: (contextEmployeeListener, stateEmployeeListener){
        print("LLegan DESDE DB ${stateEmployeeListener.isLocalEmployee}");
        if(!stateEmployeeListener.isLocalEmployee){
          print("entro");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ConnectionToGomartScreen()),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OptionsScreen()),
          );
        }
    },
      child: Container(),
    );
  }
}
