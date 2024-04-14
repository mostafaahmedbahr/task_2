 import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/models/all_books_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/sh.dart';
import '../../core/utils/app_nav.dart';
import '../book_details/book_details_screen.dart';
import '../fav/cubit/cubit.dart';
import '../fav/cubit/states.dart';

class SeeAllScreen extends StatelessWidget {
  final String type;
  final  List<AllBooksModel> booksList;
  const SeeAllScreen({super.key, required this.type, required this.booksList});

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text(type),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context , index ){
            final Uri _url = Uri.parse(booksList[index].bookUrl);
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
                        booksModel:booksList[index] ,
                        id: booksList[index].bookId,
                        name: booksList[index].bookName,
                        image:booksList[index].bookImage,
                        price: "Free",
                        rate:booksList[index].bookRate,
                        authorName: booksList[index].bookAuthorName,
                        url: booksList[index].bookUrl,
                        des: booksList[index].des,
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
                            Text(booksList[index].bookName,style: const TextStyle(
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
                                  imageUrl: booksList[index].bookImage,
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
                                    Text("author : ${booksList[index].bookAuthorName}"),
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
                                          .doc(booksList[index].bookId)
                                          .set({
                                        "bookImage" : booksList[index].bookImage ,
                                        "bookId" : booksList[index].bookId ,
                                        "bookName" : booksList[index].bookName ,
                                        "bookAuthorName" :booksList[index].bookAuthorName ,
                                        "bookType" :booksList[index].bookType ,
                                        "bookUrl" :booksList[index].bookUrl ,
                                        "bookResource" : booksList[index].bookResource ,
                                        "bookPagesNumber" : booksList[index].bookPagesNumber ,
                                        "bookRate" : booksList[index].bookRate ,
                                        "des" : booksList[index].des ,
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
                                          var isFav = favCubit.isFavorite(booksList[index].bookId);
                                          // إضافة المنتج إلى المفضلة إذا لم يكن موجودًا، وإلاّ قم بإزالته
                                          if (!isFav) {
                                            addToFavorites(booksList[index], SharedPreferencesHelper.getData(key: "userId") , favCubit);
                                          } else {
                                            removeFromFavorites(booksList[index].bookId, SharedPreferencesHelper.getData(key: "userId") , favCubit);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: FavCubit.get(context).isFavorite(booksList[index].bookId ,) ? Colors.red : Colors.grey, // تحديد لون الأيقونة بناءً على الحالة
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
            itemCount: booksList.length,
        ),
      ),
    ));
  }
}
