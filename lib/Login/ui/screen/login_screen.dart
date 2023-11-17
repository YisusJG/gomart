
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Helpers/text_field_validations.dart';
import 'package:gomart/Login/bloc/validate_login_bloc.dart';
import 'package:gomart/Login/repository/login_repository.dart';

import '../../../CommonWidget/round_textfield.dart';
import '../../../ConnectionToGomart/ui/widgets/triangle_bottom.dart';
import '../../../Constants/app_colors.dart';
import '../../../Helpers/get_color_hexadecimal.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textUserNumber = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  late FocusNode focusNodePassword;
  late FocusNode focusNodeUser;

  @override
  void initState() {
    super.initState();
    focusNodePassword = FocusNode();
    focusNodeUser = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    focusNodePassword.dispose();
    focusNodeUser.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /*Future<EmployeeModel> getUser(String user, String password) async{
      var data = await loginBloc.getUser(user, password);
      return data;
    }*/

    return MultiBlocProvider(
      providers: [BlocProvider<ValidateLoginBloc>(create: (context) => ValidateLoginBloc(RepositoryProvider.of<LoginRepository>(context)))],
      child: Scaffold(
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
            Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundTextfield(
                  bgColor: Colors.grey.shade200,
                  hintText: "Numero de usuario",
                  controller: textUserNumber,
                  keyboardType: TextInputType.number,
                  validator: (value) => validateUser(value!, focusNodeUser),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundTextfield(
                  bgColor: Colors.grey.shade200,
                  hintText: "Contraseña",
                  controller: textPassword,
                  obscureText: true,
                  validator: (value) => validatePassword(value!, focusNodePassword) ,
                ),
              ],
            ),
            ),
            Expanded(
                child: Stack(
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
                            /*getUser('10053761', '').then((value) =>{
                              messagesSnackBar("El nombre es ${value.name}")
                            });*/
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
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
