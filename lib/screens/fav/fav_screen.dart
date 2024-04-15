 import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/screens/fav/cubit/cubit.dart';
import 'package:task_2/screens/fav/cubit/states.dart';
import 'package:task_2/widgets/custom_Loading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/sh.dart';
import '../../core/utils/app_nav.dart';
import '../book_details/book_details_screen.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text("Fav Screen"),
      ),
      body: BlocConsumer<FavCubit , FavStates>(
        listener: (context , state ){},
        builder: (context , state ){
          var favCubit = FavCubit.get(context);
          void removeFromFavorites(String productId, String userId , FavCubit favCubit) async {
            try {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .collection('favorites')
                  .doc(productId)
                  .delete();
              print('Product removed from favorites successfully');
              favCubit.getFavoriteBooks(userId);
            } catch (error) {
              print('Error removing product from favorites: $error');
            }
          }

          return ConditionalBuilder(
            condition: state is ! GetFavDataLoadingState,
            fallback: (context){
              return const CustomLoading();
            },
            builder: (context){
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  itemBuilder: (context , index ){
                    final Uri _url = Uri.parse(favCubit.favoriteBooksList[index].bookUrl);
                    Future<void> _launchUrl() async {
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    }
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            AppNav.customNavigator(context: context,
                              screen: BookDetailsScreen(
                                booksModel:favCubit.favoriteBooksList[index],
                                id: favCubit.favoriteBooksList[index].bookId,
                                name: favCubit.favoriteBooksList[index].bookName,
                                image:favCubit.favoriteBooksList[index].bookImage,
                                price: "Free",
                                rate:favCubit.favoriteBooksList[index].bookRate,
                                authorName: favCubit.favoriteBooksList[index].bookAuthorName,
                                url: favCubit.favoriteBooksList[index].bookUrl,
                                des: favCubit.favoriteBooksList[index].des,
                                favOrNot: true,
                              ),
                              finish: false,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(favCubit.favoriteBooksList[index].bookName,style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20
                                  ),),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          height: 100,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          imageUrl: favCubit.favoriteBooksList[index].bookImage,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text("resource : ${favCubit.favoriteBooksList[index].bookResource}"),
                                            Text("paper number : ${favCubit.favoriteBooksList[index].bookPagesNumber}"),
                                            Text("author : ${favCubit.favoriteBooksList[index].bookAuthorName}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap : (){
                                          removeFromFavorites(favCubit.favoriteBooksList[index].bookId ,
                                              SharedPreferencesHelper.getData(key: "userId"),
                                                favCubit
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child:  const Icon(Icons.favorite,color: Colors.red,),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      InkWell(
                                        onTap : (){
                                          _launchUrl();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child:const Icon(Icons.link,color: Colors.black,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -40,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -40,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context , index ){
                    return const SizedBox(height: 20,);
                  },
                  itemCount: favCubit.favoriteBooksList.length,
                ),
              );
            },

          );
        },

      ),
    ));
  }
}
