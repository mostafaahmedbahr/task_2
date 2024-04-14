

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/screens/all_books/cubit/states.dart';

import '../../../models/all_books_model.dart';

class AllBooksCubit extends Cubit<AllBooksStates> {
  AllBooksCubit() : super(AllBooksInitState());

  static AllBooksCubit get(context) => BlocProvider.of(context);


  List<AllBooksModel> allBooksList = [];
Future<void> getAllBooksDataInAllBooks() async {
  emit(GetAllBooksLoadingState());
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AllBooks').get();
    allBooksList = querySnapshot.docs.map((doc) => AllBooksModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    emit(GetAllBooksSuccessState());
  } catch (error) {
    print("error in get all Books data ${error.toString()}");
    emit(GetAllBooksErrorState());
  }
}

}