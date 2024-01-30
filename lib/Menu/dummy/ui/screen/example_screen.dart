import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/dummy/Bloc/button/clik_save_algo_bloc.dart';
import 'package:gomart/Menu/dummy/Bloc/button/clik_save_algo_event.dart';
import 'package:gomart/Menu/dummy/ui/widgets/card_list_example.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../Bloc/button/clik_save_algo_state.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClickSaveAlgoBloc>(create: (context) => ClickSaveAlgoBloc(),
      child: BlocBuilder<ClickSaveAlgoBloc,ClickSaveAlgoState>(builder: (contextClick, stateClick){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Click bloc header",
              style: TextStyle(
                  color: Color(getColorHexadecimal(secondaryColor))),
            ),
            iconTheme: IconThemeData(
                color: Color(getColorHexadecimal(secondaryColor))),
            backgroundColor: Color(getColorHexadecimal(primaryColor)),
            actions:<Widget>[IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                contextClick.read<ClickSaveAlgoBloc>().add(ClickSaveEvent());
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Aqui recuperamos el click')));
              },
            ),],
          ),body: const Column(
          children: [
            Expanded(
                child: CardListExample()
            ),
          ],
        ),
        );
      })
    );
  }
}
