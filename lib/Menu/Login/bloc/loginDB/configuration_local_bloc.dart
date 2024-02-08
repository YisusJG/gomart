import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/login_repository.dart';
import 'configuration_local_event.dart';
import 'configuration_local_state.dart';

class ConfigurationLocalBloc extends Bloc<ConfigurationLocalEvent,ConfigurationLocalState>{
  final LoginRepository loginRepository;
  static get isSavedEmployee => null;
  ConfigurationLocalBloc(this.loginRepository):super(StartingSaveEmplopyeeState(isSavedEmployee:isSavedEmployee)){
    on<SaveEmployeeEvent>(_saveEmployeeEvent);
    on<SaveBranchEvent>(_saveBranchEvent);
  }

  void _saveEmployeeEvent(SaveEmployeeEvent event, Emitter<ConfigurationLocalState> emmit)async{
      final localEmployee = await loginRepository.saveEmployee(employeeModel: event.employeeModel);
      emmit(StartingSaveEmplopyeeState(isSavedEmployee: localEmployee));

  }

  void _saveBranchEvent(SaveBranchEvent event, Emitter<ConfigurationLocalState> emmit) async{
      final localBranch = await loginRepository.saveBranch(branchModel: event.branchModel);
      emmit(StartingSaveBranchState(isSavedBranch: localBranch));
  }
}