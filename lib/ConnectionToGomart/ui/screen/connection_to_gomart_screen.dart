import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/ConnectionToGomart/bloc/gomartApi/validate_ip_gomart_event.dart';
import 'package:gomart/ConnectionToGomart/bloc/gomartApi/validate_ip_gomart_state.dart';
import 'package:gomart/Login/ui/screen/login_screen.dart';
import '../../../Constants/app_colors.dart';
import '../../../Helpers/get_color_hexadecimal.dart';
import '../../bloc/gomartApi/validate_ip_gomart_bloc.dart';
import '../../bloc/ipInput/ip_inputs_bloc.dart';
import '../../bloc/ipInput/ip_inputs_state.dart';
import '../../repository/connection_to_gomart_repository.dart';
import '../widgets/ip_addres_input.dart';
import '../widgets/triangle_bottom.dart';

class ConnectionToGomartScreen extends StatefulWidget {
  const ConnectionToGomartScreen({super.key});

  @override
  State<ConnectionToGomartScreen> createState() => _ConnectionToGomartScreenState();
}

class _ConnectionToGomartScreenState extends State<ConnectionToGomartScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<IpInputsBloc>(create:(context)=> IpInputsBloc(),),
          BlocProvider<ValidateIpGomartBloc>(create:(context)=> ValidateIpGomartBloc(RepositoryProvider.of<ConnectionToGomartRepository>(context)))
        ],
        child: BlocBuilder<IpInputsBloc, IpInputsState>(builder:(contextInput, stateInput){
          return Scaffold(
            backgroundColor: Color(getColorHexadecimal(secondaryColor)),
            body: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 90)),
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset('assets/logos/synergo1024.png',
                          width: 250,
                          height: 40,
                        ),
                      ),
                       Align(
                        alignment: Alignment.centerRight,
                        child: Text("Gomart",
                          style: TextStyle(
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            color: Color(getColorHexadecimal(primaryColor))
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26),
                  child: IpAddressInput(),
                ),
                const Text('Ingresa la dirección IP',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors
                          .black45),
                ),
                Expanded(
                  child:BlocListener<ValidateIpGomartBloc, ValidateIpGomartState>(listener: (contextGomartListener,stateGomartListener) async {
                    if(stateGomartListener is LoadValidateIpGomartState){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                      //messagesSnackBar("carga completa ${stateGomartListener.branch?.toJson()}");

                    }else if (stateGomartListener is ErrorLoadingValidateIpGomart){
                      messagesSnackBar(stateGomartListener.errorApi);
                    }
                  },
                    child: BlocBuilder<ValidateIpGomartBloc, ValidateIpGomartState>(builder:(contextGomart,stateGomart){
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomPaint(
                            size: Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height),
                            painter: TriangleBottom(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 160),
                            child: ElevatedButton(
                              onPressed: () async {
                                //contextGomart.read<ValidateIpGomartBloc>().add(
                                  //  LoadValidateIpGomartEven(ipGomart: "10.4.137.11"));
                                if(stateInput.octetOne.isEmpty){
                                  messagesSnackBar("Favor de llenar el campo uno");
                                }else if(stateInput.octetTwo.isEmpty){
                                  messagesSnackBar("Favor de llenar el campo dos");
                                }else if(stateInput.octetThree.isEmpty){
                                  messagesSnackBar("Favor de llenar el campo tres");
                                }else if(stateInput.octetFour.isEmpty){
                                  messagesSnackBar("Favor de llenar el campo cuatro");
                                }else{
                                  contextGomart.read<ValidateIpGomartBloc>().add(
                                      LoadValidateIpGomartEven(ipGomart:"${stateInput.octetOne}.${stateInput.octetTwo}.${stateInput.octetThree}.${stateInput.octetFour}"));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(getColorHexadecimal(secondaryColor)),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    topRight: Radius.zero,
                                    bottomRight: Radius.zero,
                                  ),
                                ),
                              ),
                              child: const Text('Aceptar',
                                style: TextStyle(fontSize: 22,color: Colors.black),
                              ),

                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        })
    );
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
