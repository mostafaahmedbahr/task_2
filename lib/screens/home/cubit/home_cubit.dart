import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/all_books_model.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);


  List<AllBooksModel> bestsellersList = [];
  List<AllBooksModel> recentlyViewedList = [];
  List<AllBooksModel> genresList = [];
  List<AllBooksModel> ourTopPicksList = [];

  Future<void> getAllBooksDataInHome() async {
    emit(GetAllBooksListLoadingState());

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AllBooks').get();
      List<AllBooksModel> allBooksList = querySnapshot.docs.map((doc) => AllBooksModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
      bestsellersList = allBooksList.where((book) => book.bookType == 'Bestsellers').toList();
      recentlyViewedList = allBooksList.where((book) => book.bookType == 'RecentlyViewed').toList();
      ourTopPicksList = allBooksList.where((book) => book.bookType == 'OurTopPicks').toList();
      genresList = allBooksList.where((book) => book.bookType == 'Genres').toList();

      emit(GetAllBooksListSuccessState());
    } catch (error) {
      print("error in get all Books data ${error.toString()}");
      emit(GetAllBooksListErrorState());
    }
  }



}