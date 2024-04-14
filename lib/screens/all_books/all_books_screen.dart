 import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/screens/all_books/cubit/cubit.dart';
import 'package:task_2/screens/all_books/cubit/states.dart';
import 'package:task_2/widgets/custom_Loading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/sh.dart';
import '../../core/utils/app_nav.dart';
import '../../models/all_books_model.dart';
import '../book_details/book_details_screen.dart';
import '../fav/cubit/cubit.dart';
import '../fav/cubit/states.dart';

class AllBooksScreen extends StatelessWidget {
  const AllBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AllBooksCubit , AllBooksStates>(
        listener: (context , state ){},
        builder:  (context , state ){
          var allBooksCubit = AllBooksCubit.get(context);
          return ConditionalBuilder(
            condition: state is ! GetAllBooksLoadingState,
            fallback: (context){
              return CustomLoading();
            },
            builder: (context){
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  itemBuilder: (context , index ){
                    final Uri _url = Uri.parse(allBooksCubit.allBooksList[index].bookUrl);
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
                                booksModel: allBooksCubit.allBooksList[index],
                                id: allBooksCubit.allBooksList[index].bookId,
                                name: allBooksCubit.allBooksList[index].bookName,
                                image:allBooksCubit.allBooksList[index].bookImage,
                                price: "Free",
                                rate:allBooksCubit.allBooksList[index].bookRate,
                                authorName: allBooksCubit.allBooksList[index].bookAuthorName,
                                url: allBooksCubit.allBooksList[index].bookUrl,
                                des: allBooksCubit.allBooksList[index].des,
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
                                  Text(allBooksCubit.allBooksList[index].bookName,style: const TextStyle(
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
                                          imageUrl: allBooksCubit.allBooksList[index].bookImage,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text("resource : "),
                                            Text("paper number : "),
                                            Text("author : ${allBooksCubit.allBooksList[index].bookAuthorName}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      BlocBuilder<FavCubit, FavStates>(
                                        builder: (context, state) {
                                          void addToFavorites(
                                              AllBooksModel booksModel,
                                              String userId ,
                                              FavCubit favCubit) async
                                          {
                                            try {
                                              await FirebaseFirestore.instance.collection('BookAppUsers')
                                                  .doc(userId)
                                                  .collection('favorites')
                                                  .doc(allBooksCubit.allBooksList[index].bookId)
                                                  .set({
                                                "bookImage" : allBooksCubit.allBooksList[index].bookImage ,
                                                "bookId" : allBooksCubit.allBooksList[index].bookId ,
                                                "bookName" : allBooksCubit.allBooksList[index].bookName ,
                                                "bookAuthorName" :allBooksCubit.allBooksList[index].bookAuthorName ,
                                                "bookType" :allBooksCubit.allBooksList[index].bookType ,
                                                "bookUrl" :allBooksCubit.allBooksList[index].bookUrl ,
                                                "bookResource" : allBooksCubit.allBooksList[index].bookResource ,
                                                "bookPagesNumber" : allBooksCubit.allBooksList[index].bookPagesNumber ,
                                                "bookRate" : allBooksCubit.allBooksList[index].bookRate ,
                                                "des" : allBooksCubit.allBooksList[index].des ,
                                                ///////
                                              });
                                              print('Product added to favorites successfully');
                                              favCubit.getFavoriteBooks(userId);
                                            } catch (error) {
                                              print('Error adding product to favorites: $error');
                                            }
                                          }
                                          void removeFromFavorites(String productId, String userId , FavCubit favCubit) async {
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection('BookAppUsers')
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
                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  var favCubit = FavCubit.get(context);
                                                  // تحديد إذا كان المنتج موجودًا في المفضلة أو لا
                                                  var isFav = favCubit.isFavorite(allBooksCubit.allBooksList[index].bookId);
                                                  // إضافة المنتج إلى المفضلة إذا لم يكن موجودًا، وإلاّ قم بإزالته
                                                  if (!isFav) {
                                                    addToFavorites(allBooksCubit.allBooksList[index], SharedPreferencesHelper.getData(key: "userId") , favCubit);
                                                  } else {
                                                    removeFromFavorites(allBooksCubit.allBooksList[index].bookId, SharedPreferencesHelper.getData(key: "userId") , favCubit);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: FavCubit.get(context).isFavorite(allBooksCubit.allBooksList[index].bookId ,) ? Colors.red : Colors.grey, // تحديد لون الأيقونة بناءً على الحالة
                                                ),
                                              ),
                                            ),
                                          );
                                        },
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
                  itemCount: allBooksCubit.allBooksList.length,
                ),
              );
            },

          );
        },
       
      ),
    ));
  }
}
