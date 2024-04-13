 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/screens/search/cubit/search_states.dart';

import '../../../models/all_books_model.dart';


class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitState());

  static SearchCubit get(context) => BlocProvider.of(context);

  static List<String> allNames = [
    "mostafa",
    "aya",
    "asmaa",
    "bahr",
    "nada",
    "esraa",
    "reham",
    "kareem",
  ];


  var searchCon = TextEditingController();



  List<AllBooksModel> booksListSearchResults = [];
  void searchBook(String query) {

    if (query.isEmpty) {
      booksListSearchResults = List.from(booksList);
    }
    else {
      booksListSearchResults = booksList.where((name) => name.bookName.toLowerCase().contains(query.toLowerCase())).toList();
      //   for (var patient in patientsList) {
      //   if (patient.name.toLowerCase().contains(query.toLowerCase())) {
      //     patientsListSearchResults.add(
      //         patient); // إضافة العنصر إلى قائمة النتائج إذا تطابق مع معايير البحث
      //   }
      // }
    }
    emit(SearchLoaded());
    // بعد الانتهاء من عملية البحث، يمكنك تحديث واجهة المستخدم أو عرض النتائج كما تريد
    // يمكنك استخدام الحالة الحالية لإعادة بناء واجهة المستخدم
    // setState(() {});
  }


  List<AllBooksModel> booksList = [];

  Future<void> getAllBooksData() async {
    emit(GetAllBooksListLoadingState());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AllBooks').get();
    FirebaseFirestore.instance.collection("AllBooks").get().then((value) {
      booksList = querySnapshot.docs.map((doc) => AllBooksModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
      print(booksList);
      booksListSearchResults = booksList;
      print(booksListSearchResults);
      emit(GetAllBooksListSuccessState());
    }).catchError((error) {
      print("error in get all Books data ${error.toString()}");
      emit(GetAllBooksListErrorState());
    });
  }

}