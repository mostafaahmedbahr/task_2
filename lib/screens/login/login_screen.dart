import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/screens/layout/layout_screen.dart';
 import '../../core/app_validator.dart';
import '../../core/colors.dart';
import '../../core/utils/app_nav.dart';
import '../../widgets/custom_Loading.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_sized_box.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_form_filed.dart';
import '../register/register_screen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if(state is LoginSuccessState){
          // SharedPreferencesHelper.getData(key: "userType");
          AppNav.customNavigator(context: context,
              screen: const LayOutScreen(),
              finish: true,
          );

        }
      },
      builder: (context, state) {
        var loginCubit = LoginCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Login In"),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomSizedBox(
                        height: 100,
                      ),
                      ///login
                      const CustomText(
                        text: "Sign In",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.blackColor,
                      ),
                      const CustomSizedBox(
                        height: 40,
                      ),

                      ///  الايميل
                      CustomTextFormField(
                        controller: loginCubit.emailCon,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                      ),
                      const CustomSizedBox(
                        height: 18,
                      ),

                      /// الباسورد
                      CustomTextFormField(
                        obscureText: loginCubit.isVisible,
                        controller: loginCubit.passCon,
                        keyboardType: TextInputType.visiblePassword,
                        icon: IconButton(
                          color: AppColors.grey1Color,
                          icon: loginCubit.isVisible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            loginCubit.changeSuffixIcon();
                          },
                        ),
                        hintText: "Password",
                      ),
                      const CustomSizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        fallback: (context) {
                          return const CustomLoading();
                        },
                        builder: (context) {
                          return CustomButton(
                            height: 60,
                            width: double.infinity,
                            btnColor:Colors.white,
                            borderColor: Colors.green,
                            btnText: const CustomText(
                              text: "Login",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.blackColor,
                            ),
                            onPressed: () {
                                 loginCubit.emailCon.text =  "bbb@gmail.com";
                               loginCubit.passCon.text = "12345678";
                              if (formKey.currentState!.validate()) {
                                 loginCubit.login(context);
                              }
                            },
                          );
                        },
                      ),
                      const CustomSizedBox(
                        height: 40,
                      ),
                      /// انشاء حساب
                      CustomButton(
                        height: 60,
                        width: double.infinity,
                        btnColor: AppColors.whiteColor,
                        borderColor: Colors.green,
                        btnText: const CustomText(
                          text: "Create New Account",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.blackColor,
                        ),
                        onPressed: () {
                          AppNav.customNavigator(
                            context: context,
                            screen: const RegisterScreen(),
                            finish: false,
                          );
                        },
                      ),
                      const CustomSizedBox(
                        height: 20,
                      ),
                      const CustomSizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
