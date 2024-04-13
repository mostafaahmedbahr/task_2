 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/core/new_toast.dart';

import '../../core/app_validator.dart';
import '../../core/colors.dart';
import '../../core/utils/app_nav.dart';
import '../../widgets/custom_Loading.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_sized_box.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_form_filed.dart';
import '../layout/layout_screen.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var formKey2 = GlobalKey<FormState>();
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            //NewToast.showNewSuccessToast(msg: msg, context: context);
            AppNav.customNavigator(context: context,
                screen: const LayOutScreen(),
                finish: true,
            );
          }
        },
    builder: (context, state) {
      var registerCubit = RegisterCubit.get(context);
          return Form(
            key: formKey2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomSizedBox(
                      height: 30,
                    ),
                    const CustomSizedBox(
                      height: 30,
                    ),
                    const CustomSizedBox(
                      height: 18,
                    ),
                    CustomTextFormField(
                      controller: registerCubit.nameCon,
                      keyboardType: TextInputType.name,
                      hintText: "First Name",
                    ),
                    const CustomSizedBox(
                      height: 18,
                    ),
                    CustomTextFormField(
                      controller: registerCubit.emailCon,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Email",
                    ),
                    const CustomSizedBox(
                      height: 18,
                    ),
                
                    CustomTextFormField(
                      controller: registerCubit.mobileCon,
                      keyboardType: TextInputType.number,
                      hintText: "Mobile",
                    ),
                    const CustomSizedBox(
                      height: 18,
                    ),
                
                    CustomTextFormField(
                      controller: registerCubit.groupCodeCon,
                      keyboardType: TextInputType.text,
                      hintText: "Group Special Code (optional)",
                    ),
                    const CustomSizedBox(
                      height: 18,
                    ),
                
                    CustomTextFormField(
                      obscureText: registerCubit.isVisible,
                      controller: registerCubit.passCon,
                      keyboardType: TextInputType.visiblePassword,
                      icon: IconButton(
                        color: AppColors.grey1Color,
                        icon: registerCubit.isVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          registerCubit.changeSuffixIcon();
                        },
                      ),
                      hintText: "Password",
                    ),
                    const CustomSizedBox(
                      height: 30,
                    ),
                
                    ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      fallback: (context) {
                        return const CustomLoading();
                      },
                      builder: (context) {
                        return CustomButton(
                          height: 60,
                          width: double.infinity,
                          btnColor: Colors.white,
                          borderColor: Colors.green,
                          btnText:const CustomText(
                            text: "Create New Account",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.blackColor,
                          ),
                          onPressed: () {
                            // AppNav.customNavigator(
                            //   context: context,
                            //   screen: const LayOutScreen(),
                            //   finish: false,
                            // );

                              registerCubit.register(
                                context: context,
                                  name: registerCubit.nameCon.text,
                                  email:  registerCubit.emailCon.text,
                                  phone: registerCubit.mobileCon.text,
                                  password: registerCubit.passCon.text,
                                 groupCode: registerCubit.groupCodeCon.text,
                              );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
    },

      ),
    ));
  }
}
