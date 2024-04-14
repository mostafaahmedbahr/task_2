import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/screens/fav/cubit/states.dart';

import '../../../models/all_books_model.dart';

class FavCubit extends Cubit<FavStates> {
  FavCubit() : super(FavInitState());

  static FavCubit get(context) => BlocProvider.of(context);


  // bool isFavorite = false;
List<AllBooksModel> favoriteBooksList = [];

  bool isFavorite(String bookId) {
    // تحقق مما إذا كان المنتج موجودًا في قائمة المفضلة أم لا
    return favoriteBooksList.any((book) => book.bookId == bookId);
  }


Future<void> getFavoriteBooks(String userId) async {
  try {
    emit(GetFavDataLoadingState());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('BookAppUsers')
        .doc(userId)
        .collection('favorites')
        .get();
    favoriteBooksList = querySnapshot.docs.map((doc) {
      return AllBooksModel(
        bookId: doc['bookId'],
        bookImage: doc['bookImage'],
        bookName: doc['bookName'],
        bookAuthorName: doc['bookAuthorName'],
        bookType: doc['bookType'],
        bookUrl: doc['bookUrl'],
        bookResource: doc['bookResource'],
        bookPagesNumber: doc['bookPagesNumber'],
        bookRate: doc['bookRate'],
        des: doc['des'],
      );
    }).toList();
    emit(GetFavDataSuccessState());
    print('Favorite books retrieved successfully');
  } catch (error) {
    emit(GetFavDataErrorState());
    print('Error getting favorite books: $error');
  }
}

}