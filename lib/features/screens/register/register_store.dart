import 'package:email_validator/email_validator.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/flutter_toast_helper.dart';
import 'package:pratudo/features/models/register_user_model.dart';
import 'package:pratudo/features/repositories/authentication_repository.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  final AuthenticationRepository _repository;
  _RegisterStoreBase(this._repository);

  @observable
  String? name;

  @observable
  String? nameError;

  @observable
  String? email;

  @observable
  String? emailError;

  @observable
  String? password;

  @observable
  String? passwordError;

  @observable
  bool isObscurePassword = true;

  @action
  setObscurePassword() => isObscurePassword = !isObscurePassword;

  @observable
  bool isObscureConfirmPassword = true;

  @action
  setObscureConfirmPassword() => isObscureConfirmPassword = !isObscureConfirmPassword;

  @observable
  String? confirmPassword;

  @observable
  String? confirmPasswordError;

  @computed
  bool get isValid => _validateForm();

  bool _validateForm() {
    return name != null &&
        name!.isNotEmpty &&
        nameError == null &&
        email != null &&
        email!.isNotEmpty &&
        emailError == null &&
        password != null &&
        password!.isNotEmpty &&
        passwordError == null &&
        confirmPassword != null &&
        confirmPassword!.isNotEmpty &&
        confirmPasswordError == null;
  }

  @observable
  bool isLoading = false;

  @action
  setNameText(String value) => _setNameText(value);

  _setNameText(String value) {
    name = value;
    nameError = _validateIfIsNotEmpty(name);
  }

  @action
  setEmailText(String value) => _setEmailText(value);

  _setEmailText(String value) {
    email = value;
    emailError = _validateEmail(value);
  }

  String? _validateEmail(String? email) {
    String? error;
    error = _validateIfIsNotEmpty(email);
    if (error == null && !EmailValidator.validate(email!)) error = "Email não é válido";
    return error;
  }

  @action
  setPassword(String value) => _setPassword(value);

  _setPassword(String value) {
    password = value;
    passwordError = _validatePassword(value);
    if (passwordError == null) _validateIfPasswordMatch();
  }

  String? _validatePassword(String? password) {
    String? error;
    error = _validateIfIsNotEmpty(password);
    if (error == null && password!.length < 8) error = "Senha não é valida, mínimo 8 dígitos";
    return error;
  }

  @action
  setConfirmPassword(String value) => _setConfirmPassword(value);

  _setConfirmPassword(String value) {
    confirmPassword = value;
    confirmPasswordError = _validateIfIsNotEmpty(value);
    if (confirmPasswordError == null) _validateIfPasswordMatch();
  }

  _validateIfPasswordMatch() {
    if (password != null && confirmPassword != null && password != confirmPassword)
      confirmPasswordError = "Senhas não coincidem";
  }

  String? _validateIfIsNotEmpty(String? value) {
    if (value != null && value.isNotEmpty) return null;
    return "Campo não pode ser vazio";
  }

  Future<bool> registerUser() async {
    isLoading = true;
    final result = await _repository.register(
      RegisterUserModel(name: name!, email: email!, password: password!),
    );

    return result.fold((l) {
      FlutterToastHelper.showToast(text: l.errorText);
      isLoading = false;
      return false;
    }, (r) => true);
  }
}
