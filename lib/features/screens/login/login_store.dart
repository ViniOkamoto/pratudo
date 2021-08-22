import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/flutter_toast_helper.dart';
import 'package:pratudo/features/repositories/authentication_repository.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final AuthenticationRepository _repository;
  _LoginStoreBase(this._repository);

  @observable
  String? email;

  @observable
  String? password;

  @observable
  bool isObscurePassword = true;

  @action
  setObscurePassword() => isObscurePassword = !isObscurePassword;

  @computed
  bool get isValid => _validateForm();

  bool _validateForm() {
    return email != null && email!.isNotEmpty && password != null && password!.isNotEmpty;
  }

  @observable
  bool isLoading = false;

  @action
  setEmailText(String value) => _setEmailText(value);

  _setEmailText(String value) {
    email = value;
  }

  @action
  setPassword(String value) => _setPassword(value);

  _setPassword(String value) {
    password = value;
  }

  Future<bool> login() async {
    isLoading = true;
    final result = await _repository.login(email: email!, password: password!);

    return result.fold((l) {
      FlutterToastHelper.showToast(text: l.errorText);
      isLoading = false;
      return false;
    }, (r) => true);
  }
}
