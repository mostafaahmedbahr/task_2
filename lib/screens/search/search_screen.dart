import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../widgets/shimmer_loading.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_states.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var searchCubit = SearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: const SizedBox.shrink(),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    searchCubit.searchBook(value);
                  },
                   controller: searchCubit.searchCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffA5A5A5),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffA5A5A5),
                        )),
                    hintText: "Search",
                  ),
                ),
              ),
              searchCubit.booksList.isEmpty ?
              const SimmerLoading(
                height: 150,
                width: double.infinity,
                raduis: 10,
              )
                  :
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return
                      InkWell(
                        onTap: (){
          
                        },
                        child: Container(
                          height: 150,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 128.0,
                                  height: 128.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:
                                  CachedNetworkImage(
                                    height: 100,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    imageUrl: SearchCubit.get(context).booksListSearchResults[index].bookImage,
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        CircularProgressIndicator(value: downloadProgress.progress),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    searchCubit.booksListSearchResults[index].bookName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  Text(
                                    searchCubit.booksListSearchResults[index].bookAuthorName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  Text(
                                    searchCubit.booksListSearchResults[index].bookPrice,
                                    style:const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
               //   itemCount: searchCubit.patientsListSearchResults.length,
                  itemCount: SearchCubit.get(context).booksListSearchResults.length,
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        );
      },
    );
  }
}