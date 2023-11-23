import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/ipInput/ip_inputs_bloc.dart';
import '../../bloc/ipInput/ip_inputs_event.dart';

class IpAddressInput extends StatefulWidget {
  const IpAddressInput({super.key});

  @override
  _IpAddressInputState createState() => _IpAddressInputState();
}

class _IpAddressInputState extends State<IpAddressInput> {
  final validate = false;
  TextEditingController firstFieldController = TextEditingController();
  TextEditingController secondFieldController = TextEditingController();
  TextEditingController thirdFieldController = TextEditingController();
  TextEditingController fourthFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          child: TextField(
            controller: firstFieldController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 3,
            decoration:  const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
              // errorBorder: OutlineInputBorder(
              //   borderSide: BorderSide(color: firstFieldController.text.isEmpty ? Colors.red : Colors.red),
              // ),
            ),
            onChanged: (value){
              stationIp(context);
            },
          ),
        ),
        const Text('.',style: TextStyle(
            fontSize: 30
        ),),
        SizedBox(
          width: 60,
          child: TextField(
            controller: secondFieldController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 3,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value){
              stationIp(context);
            },
          ),
        ),
        const Text('.',style: TextStyle(
            fontSize: 30
        ),),
        SizedBox(
          width: 60,
          child: TextField(
            controller: thirdFieldController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 3,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value){
              stationIp(context);
            },
          ),
        ),
        const Text('.',style: TextStyle(
            fontSize: 30
        ),),
        SizedBox(
          width: 60,
          child: TextField(
            controller: fourthFieldController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 3,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value){
              stationIp(context);
            },
          ),
        ),
      ],
    );
  }

  void stationIp(BuildContext context){
    context.read<IpInputsBloc>().add(OctetsEvent(
        octetOne: firstFieldController.text,
        octetTwo: secondFieldController.text,
        octetThree: thirdFieldController.text,
        octetFour: fourthFieldController.text)
    );
  }
}