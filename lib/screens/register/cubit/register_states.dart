abstract class RegisterStates{}

class RegisterInitState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState({required this.error});
}

class CreateUserLoadingState extends RegisterStates{}
class CreateUserSuccessState extends RegisterStates{}
class CreateUserErrorState extends RegisterStates{
  final String error;
  CreateUserErrorState({required this.error});

}

class ChangeSuffixIconState extends RegisterStates{}
class UploadImageSuccessState extends RegisterStates{}
class UploadImageToFireStorageSuccessState extends RegisterStates{}

