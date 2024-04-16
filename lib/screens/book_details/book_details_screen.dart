 import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/models/all_books_model.dart';
import 'package:task_2/screens/fav/cubit/cubit.dart';
import 'package:task_2/screens/fav/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/sh.dart';

class BookDetailsScreen extends StatelessWidget {
  final AllBooksModel booksModel;
  final String name;
  final String id;
  final String image;
  final String price;
  final String rate;
  final String authorName;
  final String url;
  final String des;
  final bool favOrNot;
  BookDetailsScreen({super.key, required this.name, required this.image, required this.price, required this.rate, required this.authorName, required this.url, required this.favOrNot, required this.des, required this.booksModel, required this.id});

  void addToFavorites(AllBooksModel booksModel, String userId , FavCubit favCubit) async {
    try {
      await FirebaseFirestore.instance.collection('BookAppUsers')
          .doc(userId)
          .collection('favorites')
          .doc(id)
          .set({
        "bookImage" : booksModel.bookImage ,
        "bookId" : id ,
        "bookName" :booksModel.bookName ,
        "bookAuthorName" :booksModel.bookAuthorName ,
        "bookType" :booksModel.bookType ,
        "bookUrl" :booksModel.bookUrl ,
        "bookResource" : booksModel.bookResource ,
        "bookPagesNumber" : booksModel.bookPagesNumber ,
        "bookRate" : booksModel.bookRate ,
        "des" : booksModel.des ,
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
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse("$url"))) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context) {


    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    height: 300,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    imageUrl: image,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                BlocBuilder<FavCubit, FavStates>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {
                            print(id);
                            print("mostafa print id ");
                            var favCubit = FavCubit.get(context);
                            // تحديد إذا كان المنتج موجودًا في المفضلة أو لا
                            var isFav = favCubit.isFavorite(id);
                            // إضافة المنتج إلى المفضلة إذا لم يكن موجودًا، وإلاّ قم بإزالته
                            if (!isFav) {
                              addToFavorites(booksModel, SharedPreferencesHelper.getData(key: "userId") , favCubit);
                            } else {
                              removeFromFavorites(id, SharedPreferencesHelper.getData(key: "userId") , favCubit);
                            }
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: FavCubit.get(context).isFavorite(id) ? Colors.red : Colors.grey, // تحديد لون الأيقونة بناءً على الحالة
                          ),
                        ),
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: (){
                        _launchUrl();
                      },
                      icon: const Icon(Icons.link,color: Colors.black,),
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Author Name : $authorName" ,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9 , vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey.withOpacity(.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(rate),
                      Icon(Icons.star,color: Colors.yellow,)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text("price : $price",style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
            const SizedBox(
              height: 20,
            ),
            Text("Des : $des",style: const TextStyle(
                fontSize: 16
            ),),
          ],
        ),
      ),
    ));
  }
}
