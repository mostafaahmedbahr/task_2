import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../../core/colors.dart';
import '../../core/sh.dart';
import '../../models/on_boarding_model.dart';
import '../../widgets/custom_button.dart';
import '../start/start_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit,OnBoardingStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = OnBoardingCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.whiteColor,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                actions: [
                  const SizedBox(width: 5,),
                  TextButton(
                    onPressed: () {
                      SharedPreferencesHelper.saveData(key: 'isBoarding', value: true)
                          .then((value) {
                        if (value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StartScreen()),
                                  (route) => false);
                        }
                      });
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.2,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: cubit.boardingController,
                        onPageChanged: (int index) {
                          if (index == cubit.boarding.length - 1) {
                            setState(() {
                              cubit.isLast = true;
                            });
                          } else {
                            setState(() {
                              cubit.isLast = false;
                            });
                          }
                        },
                        itemBuilder: (context, index) =>
                            buildOnBoarding(cubit.boarding[index]),
                        itemCount: cubit.boarding.length,
                      ),
                    ),
                    SmoothPageIndicator(
                      controller:cubit.boardingController,
                      count: cubit.boarding.length,
                      axisDirection: Axis.horizontal,
                      effect:    ExpandingDotsEffect(
                        spacing: 10.0,
                        dotWidth: 20,
                        expansionFactor: 4.0,
                        dotHeight: 16.0,
                        dotColor:  AppColors.grey3Color.withOpacity(.5),
                        activeDotColor: Colors.green
                      ),
                    ),
                    const SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                      child: CustomButton(
                        width: double.infinity,
                          height: 60,
                          btnColor: Colors.green,
                          btnText:const Text("Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),),
                          onPressed: (){
                            if (cubit.isLast) {
                              SharedPreferencesHelper.saveData(key: 'isBoarding', value: true)
                                  .then((value) {
                                if (value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const StartScreen()),
                                          (route) => false);
                                }
                              });
                            } else {
                              cubit.boardingController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }

  Widget buildOnBoarding(OnBoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Text(
          model.titleAr!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24.0,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Center(
          child: Text(
            model.subTitleAr!,
            style: const TextStyle(
              fontSize: 20.0,
              color: AppColors.primaryColor,
            ),
           textAlign: TextAlign.center,
          ),
        ),
      ),
      const SizedBox(height: 50,),
      Image.asset(model.image!,height: 200,fit: BoxFit.fitWidth, width: double.infinity,),
      const SizedBox(height: 50,),
      Center(
        child: Text(
          model.titleEn!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24.0,
            color: Colors.green,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Center(
        child: Text(
          textAlign: TextAlign.center,
          model.subTitleEn!,
          style: const TextStyle(
            fontSize: 20.0,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    ],
  );
}
