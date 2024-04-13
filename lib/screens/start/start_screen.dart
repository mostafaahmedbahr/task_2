 import 'package:flutter/material.dart';
import 'package:task_2/screens/login/login_screen.dart';

import '../../core/colors.dart';
import '../../core/utils/app_nav.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_sized_box.dart';
import '../../widgets/custom_text.dart';
import '../register/register_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Column(
              children: [
                const Text(
                  "EDU Service App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,

                  ),
                ),
                const CustomSizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/logo 01.png",
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const CustomSizedBox(
                  height: 40,
                ),
                CustomButton(
                  height: 60,
                  width: double.infinity,
                  btnColor: Colors.green,
                  borderColor: Colors.green,
                  btnText: const CustomText(
                    text: "Sign in",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.whiteColor,
                  ),
                  onPressed: () {
                    AppNav.customNavigator(
                      context: context,
                      screen: const LoginScreen(),
                      finish: false,
                    );
                  },
                ),
                const CustomSizedBox(
                  height: 20,
                ),
                CustomButton(
                  height: 60,
                  width: double.infinity,
                  btnColor: Colors.green,
                  borderColor: Colors.green,
                  btnText: const CustomText(
                    text: "Register",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.whiteColor,
                  ),
                  onPressed: () {
                    AppNav.customNavigator(
                      context: context,
                      screen: const RegisterScreen(),
                      finish: false,
                    );
                  },
                ),
              ],
            ),
            Image.asset("assets/images/WhatsApp Image 2024-04-13 at 1.37.54 PM.jpeg"),
          ],
        ),
      ),
    ));
  }
}
