import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/options/bloc/optionDB/option_local_event.dart';
import 'package:gomart/Menu/options/bloc/optionDB/option_local_state.dart';
import 'package:gomart/Menu/options/repository/options_repository.dart';

class OptionLocalBloc extends Bloc<OptionLocalEvent, OptionLocalState>{
  final OptionsRepository optionsRepository;
  static get branchEntity => null;

  OptionLocalBloc(this.optionsRepository):super(LocalBranchLoadingState(branchEntity: branchEntity)){
    on<OptionLocalEvent>(_getBranch);
  }

  void _getBranch(OptionLocalEvent event,Emitter<OptionLocalState> emmit)async{
    final branch = await optionsRepository.getBranch();
    emmit(LocalBranchLoadingState(branchEntity: branch?.first));
  }
}