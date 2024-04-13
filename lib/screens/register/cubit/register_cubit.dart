import 'dart:developer';
import 'dart:io';

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:task_2/screens/register/cubit/register_states.dart';
 import 'package:uuid/uuid.dart';

import '../../../core/new_toast.dart';
import '../../../models/user_model.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);


void register({
  required String name,
  required String email,
  required String phone,
  required String password,
  required String groupCode,
  required BuildContext context,
}) async
{
  emit(RegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  ).then((value) {
    createUsers(
      groupCode: groupCode,
      email: email,
      name: name,
      phone: phone,
      uid: "${value.user?.uid}",
    );

    emit(RegisterSuccessState());
    NewToast.showNewSuccessToast(msg: "done", context: context);
  }).catchError((error) {
    emit(RegisterErrorState(error: error.toString()));
    log("error in register ${error.toString()}");
    NewToast.showNewErrorToast(msg: "$error", context: context);
  });
}

  var uuid = const Uuid().v4();
  var userUuid = const Uuid().v4();
  final auth = FirebaseAuth.instance;


  void createUsers({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String groupCode,
  }) async
  {
    emit(CreateUserLoadingState());
    UserModel userModel = UserModel(uid: uid,
        phone: phone,
        email: email,
        groupCode: groupCode,
        name: name,
    );
    FirebaseFirestore.instance.collection("BookAppUsers").doc(uid).set(
        userModel.toMap()).then((value) {
      emit(CreateUserSuccessState());
      log("***************");
    }).catchError((error) {
      emit(CreateUserErrorState(error: error.toString()));
      log("error in create user ${error.toString()}");
    });
  }



  var passCon = TextEditingController();
  var emailCon = TextEditingController();
  var mobileCon = TextEditingController();
  var nameCon = TextEditingController();
  var codeCon = TextEditingController();
  var groupCodeCon = TextEditingController();


  bool isVisible = true;

  void changeSuffixIcon() {
    isVisible = !isVisible;
    emit(ChangeSuffixIconState());
  }


  File? file;
  Future uploadOnlyImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["jpg", "png", "jpeg"],
      type: FileType.custom,
    );
    file = File(result?.files.single.path ?? "");
    debugPrint("---------- uplod is done ------------");
    // uploadImageToFirebase();
    emit(UploadImageSuccessState());
  }

  String? imageUrl;
  Future<void> uploadImageToFirebase() async {
    if (file == null) return;
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('BookAppUsers_images/${DateTime.now()}.jpg');
      final UploadTask uploadTask = storageReference.putFile(file!);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl = downloadUrl;
      log(imageUrl!);
     emit(UploadImageToFireStorageSuccessState());
    } catch (error) {
      log('Error uploading image: $error');
    }
  }




}