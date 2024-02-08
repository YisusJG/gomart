import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/options/bloc/optionDB/option_local_bloc.dart';
import 'package:gomart/Menu/options/bloc/optionDB/option_local_event.dart';
import 'package:gomart/Menu/options/bloc/optionDB/option_local_state.dart';
import 'package:gomart/Menu/options/repository/options_repository.dart';
import 'package:gomart/Menu/options/ui/widgets/custom_gomart_name.dart';

import '../../../../Widgets/app_bar_menu.dart';
import '../../models/options.dart';
import '../widgets/custom_oval_button.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  final List<Options> _options = Options.menu;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(create: (context) => OptionsRepository(),
      child: MultiBlocProvider(providers: [
        BlocProvider<OptionLocalBloc>(create: (context)=> OptionLocalBloc(RepositoryProvider.of<OptionsRepository>(context))..add(GetBranchEvent(branchEntity: null)))
      ],
          child: BlocBuilder<OptionLocalBloc,OptionLocalState>(builder: (contextOption,stateOption){
            return PopScope(
              canPop: false,
              onPopInvoked: (bool didPop){
                if (didPop) {
                  return;
                }
              },
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: MediaQuery.of(context).size * 0.060,
                  child: const AppBarMenu(),
                ),
                body: Stack(
                  children: [
                    Column(
                      children: [
                        if(stateOption.branchEntity != null)
                          CustomGomartName(branchEntity: stateOption.branchEntity,),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _options.take(2).map((options) => CustomOvalButton(menu: options)).toList(),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _options.skip(2).take(1).map((options) => CustomOvalButton(menu: options)).toList(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          })
      ),
    );
  }
}
