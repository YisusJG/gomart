import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/ConnectionToGomart/bloc/gomartApi/validate_ip_gomart_event.dart';
import 'package:gomart/ConnectionToGomart/bloc/gomartApi/validate_ip_gomart_state.dart';
import 'package:gomart/ConnectionToGomart/repository/connection_to_gomart_repository.dart';

class ValidateIpGomartBloc extends Bloc<LoadValidateIpGomartEven,ValidateIpGomartState>{
  final ConnectionToGomartRepository connectionToGomartRepository;


  ValidateIpGomartBloc(this.connectionToGomartRepository):super(StartingValidateIpGomart(branchModel: null)){
    on<LoadValidateIpGomartEven>(_gomartLoadingEvent);
  }

  void _gomartLoadingEvent(LoadValidateIpGomartEven event,Emitter<ValidateIpGomartState> emit)async{
    try{
      emit(StartingValidateIpGomart(branchModel: null));
      print("llega ${event.ipGomart}");
      final gomart = await connectionToGomartRepository.getBranchGomart(ipGomart: event.ipGomart);
      emit(LoadValidateIpGomartState(branchModel: gomart));
    }catch(e){
      emit(ErrorLoadingValidateIpGomart(error: e.toString()));
    }
  }
}