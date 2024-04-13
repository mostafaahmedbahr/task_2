 import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_2/models/all_books_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/app_nav.dart';
import '../book_details/book_details_screen.dart';

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
                        name: booksList[index].bookName,
                        image:booksList[index].bookImage,
                        price: booksList[index].bookPrice,
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
                              InkWell(
                                onTap : (){},
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
            itemCount: booksList.length,
        ),
      ),
    ));
  }
}