

 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:task_2/screens/on_boarding/cubit/states.dart';

import '../../../models/on_boarding_model.dart';


class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingStatesInitState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  var boardingController = PageController();
  bool isLast = false;

  List<OnBoardingModel> boarding = [
    OnBoardingModel(
        "assets/images/WhatsApp Image 2024-04-13 at 1.27.23 PM.jpeg",
       "تكنولوجيا التعليم",
       "كتب عن تكنولوجيا التعليم",
       "EDU Technology",
       "Books on educational technology",

    ),
    OnBoardingModel(
        "assets/images/WhatsApp Image 2024-04-13 at 1.26.20 PM.jpeg",
        "الرسائل و البحوث في تكنولوجيا التعليم",
        "رسائل وأبحاث ومعلومات حول تكنولوجيا التعليم",
        "Letters and research in educational technology",
        "Letters, research and other information about educational technology",
    ),
    OnBoardingModel(
        "assets/images/WhatsApp Image 2024-04-13 at 1.21.34 PM.jpeg",
      "مصطلحات في تكنولوجيا التعليم",
      "مصطلحات لأكثر من عالم في تكنولوجيا التعليم",
      "Glossary of terms in educational technology",
      "Terms for more than one scientist in educational technology",
    ),
  ];

}
