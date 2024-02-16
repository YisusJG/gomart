
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/ConnectionToGomart/models/branch_model.dart';
import 'package:gomart/Menu/home/ui/screen/home_screen.dart';
import '../../../../ConnectionToGomart/ui/widgets/triangle_bottom.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../bloc/loginDB/configuration_local_bloc.dart';
import '../../bloc/loginDB/configuration_local_event.dart';
import '../../bloc/loginDB/configuration_local_state.dart';
import '../../bloc/loginInput/login_input_bloc.dart';
import '../../bloc/loginInput/login_input_state.dart';
import '../../bloc/validateLoginApi/validate_login_bloc.dart';
import '../../bloc/validateLoginApi/validate_login_event.dart';
import '../../bloc/validateLoginApi/validate_login_state.dart';
import '../../models/employee_model.dart';
import '../../repository/login_repository.dart';
import '../widgets/login_input.dart';

class LoginScreen extends StatefulWidget {
  final BranchModel branchModel;
  const LoginScreen({super.key, required this.branchModel});

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

    return RepositoryProvider(create: (context) => LoginRepository(),
    child:MultiBlocProvider(
      providers: [
        BlocProvider<LoginInputBloc>(create:(context)=> LoginInputBloc(),),
        BlocProvider<ValidateLoginBloc>(create: (context) => ValidateLoginBloc(RepositoryProvider.of<LoginRepository>(context))),
        BlocProvider<ConfigurationLocalBloc>(create: (context) => ConfigurationLocalBloc(RepositoryProvider.of<LoginRepository>(context)))
      ],
      child: BlocBuilder<LoginInputBloc, LoginInputState>(builder:(contextInput,stateInput){
        return Scaffold(
          backgroundColor: Color(getColorHexadecimal(secondaryColor)),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 90)),
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.5,
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
                const Padding(padding:  EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: LoginInput(),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: MediaQuery.of(context).size.height/1.824,
                  child: BlocBuilder<ConfigurationLocalBloc,ConfigurationLocalState>(builder: (contextDB, stateDB){
                    return BlocListener<ValidateLoginBloc,ValidateLoginState>(listener:(contextLoginListener, stateLoginListener) async{
                      if(stateLoginListener is LoadValidateLoginState){
                        _onSavedEmployeeBranch(contextDB, stateLoginListener.employeeModel!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                        //messagesSnackBar("carga completa ${stateLoginListener.employeeModel?.toJson()}");

                      }else if (stateLoginListener is ErrorLoadValidateLogin){
                        messagesSnackBar(stateLoginListener.errorApi);
                      }
                    },
                      child: BlocBuilder<ValidateLoginBloc,ValidateLoginState>(builder:(contextLogin,stateLogin){
                        return Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            CustomPaint(
                              size: Size(MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height),
                              painter: TriangleBottom(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if(stateInput.user.isEmpty){
                                    messagesSnackBar("Favor de agregar un numero de usuario");
                                  }else if(stateInput.password.isEmpty){
                                    messagesSnackBar("Favor de agregar una contraseña");
                                  }else{
                                    contextLogin.read<ValidateLoginBloc>().add(LoadValidateLoginEvent(user: stateInput.user, password: stateInput.password));
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
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    )
    );
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onSavedEmployeeBranch(BuildContext context, EmployeeModel employeeModel) {
    BlocProvider.of<ConfigurationLocalBloc>(context).add(SaveBranchEvent(branchModel: widget.branchModel));
    BlocProvider.of<ConfigurationLocalBloc>(context).add(SaveEmployeeEvent(employeeModel:employeeModel));
  }

}
