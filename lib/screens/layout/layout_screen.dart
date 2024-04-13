 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/colors.dart';
import 'cubit/layout_cubit.dart';
import 'cubit/layout_states.dart';

class LayOutScreen extends StatelessWidget {
  const LayOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var layoutCubit = LayoutCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: layoutCubit.screens[LayoutCubit.pageIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: LayoutCubit.pageIndex,
              onTap: (index){
                layoutCubit.changeBottomNav(index);
              },
              selectedItemColor: Colors.green,
              unselectedItemColor: AppColors.primaryColor,
              type: BottomNavigationBarType.fixed,
              items:   const [
                BottomNavigationBarItem(
                 // activeIcon:  SvgPicture.asset("assets/images/explore.svg",color: AppColors.mainColor,),
                    icon: Icon(Icons.home_filled),
                label: "Home"
                ),
                BottomNavigationBarItem(
                   // activeIcon:  SvgPicture.asset("assets/images/services.svg",color: AppColors.mainColor,),
                    icon:  Icon(Icons.search),
                label: "Search"
                ),
                BottomNavigationBarItem(
                  //  activeIcon:  SvgPicture.asset("assets/images/booking.svg",color: AppColors.mainColor,),
                    icon:  Icon(Icons.favorite),
                    label: "Favorite"
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
