import 'package:chatting_app/models/social_user_model.dart';
import 'package:chatting_app/social_register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.uid);
      print(value.user?.email);
      userCreate(
        name: name,
        email: email,
        password: password,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print('the error is ${error.toString()}');
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      email: email,
      name: name,
      password: password,
      phone: phone,
      uId: uId,
      coverImage:
          'https://img.freepik.com/free-photo/dogs-enjoying-beautiful-view-hot-balloons-sky-during-sunset-cappadocia-turkey_181624-23905.jpg?t=st=1651818715~exp=1651819315~hmac=d4bf69ba345885c58778568f90b0c07fe90919d495867a85ec805d067555658d&w=996',
      bio: 'Write your bio....',
      image:
          'https://img.freepik.com/free-vector/illustration-concept-young-man-who-lost-his-zest-life_10045-682.jpg?w=740&t=st=1651805504~exp=1651806104~hmac=7e797c95e4a26f56a54351dac2507c3d461dfb1df9e8f00c68fe6eeb2430bcd5',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  // void userRegister({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String phone,
  // }) {
  //   print('hello');
  //
  //   emit(SocialRegisterLoadingState());
  //
  //   FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   )
  //       .then((value) {
  //     userCreate(
  //       uId: value.user.uid,
  //       phone: phone,
  //       email: email,
  //       name: name,
  //
  //     );
  //   }).catchError((error) {
  //     emit(SocialRegisterErrorState(error.toString()));
  //   });
  // }

  // void userCreate({
  //   @required String name,
  //   @required String email,
  //   @required String phone,
  //   @required String uId,
  // }) {
  //   SocialUserModel model = SocialUserModel(
  //     name: name,
  //     email: email,
  //     phone: phone,
  //     uId: uId,
  //     bio: 'write you bio ...',
  //     cover: 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
  //     image: 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
  //     isEmailVerified: false,
  //   );
  //
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uId)
  //       .set(model.toMap())
  //       .then((value)
  //   {
  //         emit(SocialCreateUserSuccessState());
  //   })
  //       .catchError((error) {
  //         print(error.toString());
  //     emit(SocialCreateUserErrorState(error.toString()));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
