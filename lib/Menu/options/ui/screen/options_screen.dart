import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.060,
        child: const AppBarMenu(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const CustomGomartName(),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _options.take(2).map((options) => CustomOvalButton(menu: options)).toList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
