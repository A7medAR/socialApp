import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/modules/social_app/social_register/cubit/states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit():super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=> BlocProvider.of(context);
bool isPassword=true;
  IconData suffix=Icons.visibility_off_outlined;
  void changePassword(){
    isPassword= !isPassword;
    suffix=isPassword?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  })
  {
    emit(SocialRegisterLoadingState());
   FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)
   {
     print(value.user?.email);
     print(value.user?.uid);
     userCreate(
         name: name,
         email: email,
         phone: phone,
         uId: value.user!.uid
     );
     emit(SocialRegisterSuccessState());
   }
   ).catchError((error)
   {
     print(error.toString());
     emit(SocialRegisterErrorState(error.toString()));
   }
   );
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,

  })
  {
    SocialUserModel model =SocialUserModel(
      name: name,
      email: email,
      uId: uId,
      bio: 'write your bio ...',
      image: 'https://img.freepik.com/premium-photo/portrait-young-woman-standing-against-blue-background_1048944-22862481.jpg?w=996',
      phone: phone,
      cover: 'https://img.freepik.com/premium-photo/html-system-websites-collage-design_23-2150432963.jpg?w=996',
      isEmailVerified:false,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

}