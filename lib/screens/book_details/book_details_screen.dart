 import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsScreen extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String rate;
  final String authorName;
  final String url;
  final String des;
  final bool favOrNot;
  const BookDetailsScreen({super.key, required this.name, required this.image, required this.price, required this.rate, required this.authorName, required this.url, required this.favOrNot, required this.des});
  

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse("$url");
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.favorite,color: Colors.red,),
                    ),
                  ),
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
