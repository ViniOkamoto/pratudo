import 'package:mobx/mobx.dart';
import 'package:pratudo/features/repositories/authentication_repository.dart';

part 'user_information_store.g.dart';

class UserInformationStore = _UserInformationStoreBase with _$UserInformationStore;

abstract class _UserInformationStoreBase with Store {
  final AuthenticationRepository _repository;
  _UserInformationStoreBase(this._repository);

  Future<bool> checkIfUserIsLogged() async {
    final result = await _repository.checkIfUserLogged();

    return result.fold((l) => false, (r) => r);
  }
}
