import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Splahs/bloc/splahsDB/splahs_local_bloc.dart';
import 'package:gomart/Splahs/bloc/splahsDB/splahs_local_event.dart';
import 'package:gomart/Splahs/repository/splahs_repository.dart';
import 'package:gomart/Splahs/ui/screen/splahs_screen.dart';


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
        create: (context) => SplahsRepository(),
        child: BlocProvider<SplahsLocalBloc>(create: (context)=> SplahsLocalBloc(RepositoryProvider.of<SplahsRepository>(context))..add(ValidateEmployeeEvent(isLocalEmploye: null)),
        child: const SplahsScreen(),
        )
      ),
    );
  }
}