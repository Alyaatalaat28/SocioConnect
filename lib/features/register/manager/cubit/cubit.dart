import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/features/login/data/create_user_model.dart';
import 'package:flutter_applicaion/features/register/manager/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SocialRegisterCubit extends Cubit< SocialRegisterStates>{

  SocialRegisterCubit() : super( SocialRegisterInitialState());

  static  SocialRegisterCubit get(context)=>BlocProvider.of(context);



  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          createUser(
            name: name,
            phone:phone,
            email:email,
            uId:value.user!.uid,
          );
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorState());
    });
  }

  void createUser({
    required String name,
    required String email,
    required String uId,
    required String phone,
    String? bio,

}){
    SocialUserModel model=SocialUserModel(
        name:name,
        phone:phone,
        email:email,
        uId:uId,
        bio:bio,
        image:'https://img.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg?w=740&t=st=1679132045~exp=1679132645~hmac=010d7275ebc985e25c108c8ba6038ec01a19a746dca5fc41f271d2ff68232da2',
        cover:'https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?w=740&t=st=1679131461~exp=1679132061~hmac=82faa8e7683e35269c88e53904b8a82d9bae6b0ffc47baa11773eb27d70c4e04',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set
      (model.toMap()).then((value){
      emit(SocialCreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialCreateUserErrorState());
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit( SocialRegisterPasswordVisibilityState());
  }


}