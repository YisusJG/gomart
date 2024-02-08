import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/loginInput/login_input_bloc.dart';
import '../../bloc/loginInput/login_input_event.dart';

class LoginInput extends StatefulWidget {
  const LoginInput({super.key});

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: userController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'Número de usuario',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
          ),
          onChanged: (value) {
            loginUser(context);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'Contraseña',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
          ),
          onChanged: (value) {
            loginUser(context);
          },
        ),
      ],
    );
  }

  void loginUser(BuildContext context) {
    context.read<LoginInputBloc>().add(
      LoginEvent(
        user: userController.text,
        password: passwordController.text,
      ),
    );
  }
}


