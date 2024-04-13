 import 'package:flutter_bloc/flutter_bloc.dart';

import '../../fav/fav_screen.dart';
import '../../home/home_screen.dart';
import '../../search/search_screen.dart';
import 'layout_states.dart';



class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  static int pageIndex = 0;
  List screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavScreen(),


  ];


  changeBottomNav(index) {
    pageIndex = index;
    emit(ChangeBottomNavState());
  }





}