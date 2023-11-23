import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Splahs/bloc/splahsDB/splahs_local_event.dart';
import 'package:gomart/Splahs/bloc/splahsDB/splahs_local_state.dart';
import 'package:gomart/Splahs/repository/splahs_repository.dart';

class SplahsLocalBloc extends Bloc<SplahsLocalEvent,SplahsLocalState>{
  final SplahsRepository splahsRepository;
  static get isLocalEmployee => false;

  SplahsLocalBloc(this.splahsRepository):super(LocalEmployeeLoadingState(isLocalEmployee: isLocalEmployee)){
    on<SplahsLocalEvent>(_validateEmployee);
  }

  void _validateEmployee(SplahsLocalEvent event, Emitter<SplahsLocalState> emmit) async{
    late bool? isEmployeeLocal;
    final employee = await splahsRepository.validateEmployee();
    print("Datos empleado ${employee!.length}");
    if(employee.isNotEmpty){
      isEmployeeLocal = true;
    }else{
      isEmployeeLocal = false;
    }
    emmit(LocalEmployeeLoadingState(isLocalEmployee: isEmployeeLocal));
  }

}