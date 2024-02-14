import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/ConnectionToGomart/bloc/conecctionApi/validate_ip_gomart_event.dart';
import 'package:gomart/ConnectionToGomart/bloc/conecctionApi/validate_ip_gomart_state.dart';
import 'package:gomart/ConnectionToGomart/repository/connection_to_gomart_repository.dart';

class ValidateIpGomartBloc extends Bloc<ValidateIpGomartEvent,ValidateIpGomartState>{
  final ConnectionToGomartRepository connectionToGomartRepository;


  ValidateIpGomartBloc(this.connectionToGomartRepository):super(StartingValidateIpGomart(branchModel: null)){
    on<LoadValidateIpGomartEvent>(_gomartLoadingEvent);
    on<SaveIpGomartEvent>(_saveIpGomartEvent);
  }

  void _gomartLoadingEvent(LoadValidateIpGomartEvent event,Emitter<ValidateIpGomartState> emit)async{
    try{
      emit(StartingValidateIpGomart(branchModel: null));
      print("llega ${event.ipGomart}");
      final gomart = await connectionToGomartRepository.getBranchGomart(ipGomart: event.ipGomart);
      emit(LoadValidateIpGomartState(branchModel: gomart));
    }catch(e){
      emit(ErrorLoadingValidateIpGomart(error: e.toString()));
    }
  }

  void _saveIpGomartEvent(SaveIpGomartEvent event,Emitter<ValidateIpGomartState> emit) async {
    debugPrint("Se guardara la ip ${event.ipGomartModal.ip} ");
    final ipGomart = await connectionToGomartRepository.saveIpGomart(ipGomartModal: event.ipGomartModal);
    emit(StartingSaveIpGomartState(isSaveIpGomart: ipGomart));
  }

}