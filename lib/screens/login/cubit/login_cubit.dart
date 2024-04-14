 import 'dart:developer';

 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 import '../../../core/sh.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  var passCon = TextEditingController();
  var emailCon = TextEditingController();
  var mobileCon = TextEditingController();

  bool isVisible = true;

  void changeSuffixIcon() {
    isVisible = !isVisible;
    emit(ChangeSuffixIconState());
  }


  void login(context)async
  {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailCon.text,
      password: passCon.text,
    ).then((value)
    {
      emit(LoginSuccessState());
      log(value.user!.uid);
      // ProfileCubit.get(context).getUserById(value.user!.uid);
      SharedPreferencesHelper.saveData(key: "userId", value: value.user?.uid);
      log("success");
    }).catchError((error)
    {
      emit(LoginErrorState(error.toString()));
      log("error in login ${error.toString()}");
    });
  }


}
