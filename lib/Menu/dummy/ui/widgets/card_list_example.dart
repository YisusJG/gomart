import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/button/clik_save_algo_bloc.dart';
import '../../Bloc/button/clik_save_algo_state.dart';
import 'card_example.dart';


class CardListExample extends StatefulWidget {
  const CardListExample({super.key});

  @override
  State<CardListExample> createState() => _CardListExampleState();
}

class _CardListExampleState extends State<CardListExample> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ClickSaveAlgoBloc,ClickSaveAlgoState>(listener: (contextClick, stateClick){
      debugPrint("llega ${stateClick.onClick}");
    },child:ListView.builder(

        itemCount: 5,
        itemBuilder: (context,index) {
          return SizedBox(
            height: MediaQuery.of(context).size.height/5.5,
            child: const CardExample(),
          );
        }
    ),
    );
  }
}
