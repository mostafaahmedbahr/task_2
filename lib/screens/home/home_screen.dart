 import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/core/utils/app_nav.dart';
import 'package:task_2/widgets/custom_Loading.dart';

import '../book_details/book_details_screen.dart';
 import '../see_all/see_all_screen.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
      ),
      endDrawer:   Drawer(
        child: ListView(
          children:  [
            const  DrawerHeader(
        child: Text(
          'Drawer Header',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
             ListTile(
    leading: const Icon(Icons.home),
    title: const Text('Home'),
    onTap: () {
    Navigator.pop(context);
  },
    ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Our Books'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_input_antenna_sharp),
              title: const Text('Our Research'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
    ],
        ),
      ),
      body: BlocConsumer<HomeCubit , HomeStates>(
        listener: (context , state ){},
        builder: (context , state ){
          return  ConditionalBuilder(
            condition: state is ! GetAllBooksListLoadingState,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    if(HomeCubit.get(context).ourTopPicksList.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Our Top Picks",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),),
                              TextButton(onPressed: (){
                                AppNav.customNavigator(context: context,
                                    screen:   SeeAllScreen(
                                      type: "Our Top Picks",
                                      booksList : HomeCubit.get(context).ourTopPicksList,
                                    ),
                                    finish: false,
                                );
                              },
                                  child:   const Text("See All",
                                    style: TextStyle(
                                        fontSize: 20,
                                      color: Colors.green,
                                    ),),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          SizedBox(
                            height: 150,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index ){
                                return InkWell(
                                  onTap: (){
                                    AppNav.customNavigator(context: context,
                                      screen: BookDetailsScreen(
                                          name: HomeCubit.get(context).ourTopPicksList[index].bookName,
                                          image:HomeCubit.get(context).ourTopPicksList[index].bookImage,
                                          price: HomeCubit.get(context).ourTopPicksList[index].bookPrice,
                                          rate:HomeCubit.get(context).ourTopPicksList[index].bookRate,
                                          authorName: HomeCubit.get(context).ourTopPicksList[index].bookAuthorName,
                                          url: HomeCubit.get(context).ourTopPicksList[index].bookUrl,
                                          des: HomeCubit.get(context).ourTopPicksList[index].des,
                                          favOrNot: true,
                                      ),
                                      finish: false,
                                    );
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          height: 100,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          imageUrl: HomeCubit.get(context).ourTopPicksList[index].bookImage,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                        Expanded(
                                          child: Text(HomeCubit.get(context).ourTopPicksList[index].bookName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis,

                                            ),),
                                        ),
                                        Expanded(
                                          child: Text(
                                            HomeCubit.get(context).ourTopPicksList[index].bookAuthorName ,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                            ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context , index ){
                                return const SizedBox(width: 10,);
                              },
                              itemCount: HomeCubit.get(context).ourTopPicksList.length,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20,),
                    if(HomeCubit.get(context).bestsellersList.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Bestsellers",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),),
                              TextButton(onPressed: (){
                                AppNav.customNavigator(context: context,
                                  screen: SeeAllScreen(
                                    type: "Bestsellers",
                                      booksList : HomeCubit.get(context).bestsellersList,
                                  ),
                                  finish: false,
                                );
                              },
                                child:   const Text("See All",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          SizedBox(
                            height: 150,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index ){
                                return InkWell(
                                  onTap: (){
                                    AppNav.customNavigator(context: context,
                                      screen: BookDetailsScreen(
                                        name: HomeCubit.get(context).bestsellersList[index].bookName,
                                        image:HomeCubit.get(context).bestsellersList[index].bookImage,
                                        price: HomeCubit.get(context).bestsellersList[index].bookPrice,
                                        rate:HomeCubit.get(context).bestsellersList[index].bookRate,
                                        authorName: HomeCubit.get(context).bestsellersList[index].bookAuthorName,
                                        url: HomeCubit.get(context).bestsellersList[index].bookUrl,
                                        des: HomeCubit.get(context).bestsellersList[index].des,
                                        favOrNot: true,
                                      ),
                                      finish: false,
                                    );
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          height: 100,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          imageUrl: HomeCubit.get(context).bestsellersList[index].bookImage,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                        Expanded(
                                          child: Text(HomeCubit.get(context).bestsellersList[index].bookName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis,

                                            ),),
                                        ),
                                        Expanded(
                                          child: Text(
                                            HomeCubit.get(context).bestsellersList[index].bookAuthorName ,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                            ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context , index ){
                                return const SizedBox(width: 10,);
                              },
                              itemCount: HomeCubit.get(context).bestsellersList.length,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20,),
                    if(HomeCubit.get(context).genresList.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Genres",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),),
                                TextButton(onPressed: (){
                                  AppNav.customNavigator(context: context,
                                    screen: SeeAllScreen(
                                      type: "Genres",
                                      booksList : HomeCubit.get(context).genresList,
                                    ),
                                    finish: false,
                                  );
                                },
              child:   const Text("See All",
              style: TextStyle(
              fontSize: 20,
              color: Colors.green,
              ),),
                                ),

                            ],
                          ),
                          const SizedBox(height: 20,),
                          SizedBox(
                            height: 150,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index ){
                                return InkWell(
                                  onTap: (){
                                    AppNav.customNavigator(context: context,
                                      screen: BookDetailsScreen(
                                        name: HomeCubit.get(context).genresList[index].bookName,
                                        image:HomeCubit.get(context).genresList[index].bookImage,
                                        price: HomeCubit.get(context).genresList[index].bookPrice,
                                        rate:HomeCubit.get(context).genresList[index].bookRate,
                                        authorName: HomeCubit.get(context).genresList[index].bookAuthorName,
                                        url: HomeCubit.get(context).genresList[index].bookUrl,
                                        des: HomeCubit.get(context).genresList[index].des,
                                        favOrNot: true,
                                      ),
                                      finish: false,
                                    );
                                  },
                                  child: SizedBox(
                                    width: 200,
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          height: 150,
                                          fit: BoxFit.cover,
                                          width: 250,
                                          imageUrl: HomeCubit.get(context).genresList[index].bookImage,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context , index ){
                                return const SizedBox(width: 10,);
                              },
                              itemCount:  HomeCubit.get(context).genresList.length,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Recently Viewed",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                              ),),
                            TextButton(onPressed: (){
                              AppNav.customNavigator(context: context,
                                screen: SeeAllScreen(
                                  type: "Recently Viewed",
                                  booksList : HomeCubit.get(context).recentlyViewedList,
                                ),
                                finish: false,
                              );
                            },
                              child:   const Text("See All",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                ),),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context , index ){
                              return InkWell(
                                onTap: (){
                                  AppNav.customNavigator(context: context,
                                      screen: BookDetailsScreen(
                                        name: HomeCubit.get(context).bestsellersList[index].bookName,
                                        image:HomeCubit.get(context).bestsellersList[index].bookImage,
                                        price: HomeCubit.get(context).bestsellersList[index].bookPrice,
                                        rate:HomeCubit.get(context).bestsellersList[index].bookRate,
                                        authorName: HomeCubit.get(context).bestsellersList[index].bookAuthorName,
                                        url: HomeCubit.get(context).bestsellersList[index].bookUrl,
                                        des: HomeCubit.get(context).bestsellersList[index].des,
                                        favOrNot: true,
                                      ),
                                      finish: false,
                                  );
                                },
                                child: SizedBox(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        height: 100,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        imageUrl: HomeCubit.get(context).bestsellersList[index].bookImage,
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            CircularProgressIndicator(value: downloadProgress.progress),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                      Expanded(
                                        child: Text(HomeCubit.get(context).recentlyViewedList[index].bookName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            overflow: TextOverflow.ellipsis,

                                          ),),
                                      ),
                                      Expanded(
                                        child: Text(
                                          HomeCubit.get(context).recentlyViewedList[index].bookAuthorName ,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                          ),),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context , index ){
                              return const SizedBox(width: 10,);
                            },
                            itemCount: HomeCubit.get(context).recentlyViewedList.length,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              );
            },
            fallback: (BuildContext context) {
              return const CustomLoading();
            },

          );
        },

      ),
    );
  }
}
