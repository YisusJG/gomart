import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/ConnectionToGomart/repository/connection_to_gomart_repository.dart';
import 'package:gomart/ConnectionToGomart/ui/screen/connection_to_gomart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => ConnectionToGomartRepository(),
        child: const ConnectionToGomartScreen(),
      ),
    );
  }
}