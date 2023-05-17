
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/layout/social_app/cubit/states.dart';
import 'package:flutter_applicaion/models/socialApp/create_user_model.dart';
import 'package:flutter_applicaion/modules/social_app/chats/chats_screen.dart';
import 'package:flutter_applicaion/modules/social_app/feeds/feeds_screen.dart';
import 'package:flutter_applicaion/modules/social_app/newPost/new_post_screen.dart';
import 'package:flutter_applicaion/modules/social_app/settings/settings_screen.dart';
import 'package:flutter_applicaion/modules/social_app/users/users_screen.dart';
import 'package:flutter_applicaion/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/socialApp/message_model.dart';
import '../../../models/socialApp/post_model.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context)=>BlocProvider.of(context);

  SocialUserModel? userModel;
  void getUserData(){
    emit(SociaGetUserLoadingState()); 
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)
    {
        userModel=SocialUserModel.fromjson(value.data()!);
        emit(SociaGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SociaGetUserErrorState(error));

    });
  }
  List<Widget> screens=const[
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SocialSettingsScreen(),
  ];
  List<String> titles=[
    'New Feeds',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];
  int currentIndex=0;
  void changeBottomNavBar(int index){
    if(index==1){
      getAllUsers();
    }
    if(index==2){
      emit(SocialNewPostState());
    }else{
    currentIndex=index;
    emit(SocialChangeBottomNavBarState());
  }}

   File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
       profileImage = File(pickedFile.path);
       emit(SocialProfileImagePickedSuccessState());
      } else {
        print('No image selected.');
        emit(SociallProfileImagePickedErrorState());
      }
  }
  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
       coverImage = File(pickedFile.path);
       emit(SociallCoverImagePickedSuccessState());
      } else {
        print('No image selected.');
        emit(SociallCoverImagePickedErrorState());
      }
  }

void uploadProfileImage({
  required String name,
  required String bio,
}){
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.
    instance.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}').
    putFile(profileImage!).then((value) 
    { 
      value.ref.getDownloadURL().
      then((value) {
        updateUserData(
          name: name,
           bio: bio,
           image: value,
           );
       
      }).catchError((error){
        print(error.toString());
        emit(SociallProfileImageUploadErrorState());
      });
    }).
    catchError((error){
        print(error.toString());
        emit(SociallProfileImageUploadErrorState());
    });
    
}

void uploadCoverImage({
  required String name,
  required String bio,
}){
    emit(SocialUpdateLoadingState());
    firebase_storage.FirebaseStorage.
    instance.ref().child('users/${Uri.file(coverImage!.path).pathSegments.last}').
    putFile(coverImage!).then((value) 
    { 
      value.ref.getDownloadURL().
      then((value) {
        print(value);
        updateUserData(
          name: name,
         bio: bio,
         cover: value,
         );
      }).catchError((error){
        print(error.toString());
        emit(SociallCoverImageUploadErrorState());
      });
    }).
    catchError((error){
        emit(SociallCoverImageUploadErrorState());
    });
}

void updateUserData({
  required String name,
  required String bio,
    String? image,
    String ?cover,
    }
){
    SocialUserModel model=SocialUserModel(
        name:name,
        phone:userModel!.phone,
        email:userModel!.email,
        uId:userModel!.uId,
        bio:bio,
        image:image??userModel!.image,
        cover:cover??userModel!.cover,
        isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update(model.toMap()).
    then((value) {
       getUserData();
    }).catchError((error){
       emit(SocialUserUpdateErrorState());
    });
}

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
       postImage = File(pickedFile.path);
       emit(SocialPostImagePickedSuccessState());
      } else {
        print('No image selected.');
        emit(SocialPostImagePickedErrorState());
      }
  }

void createPost({
  required String text,
  required String dateTime,
  String? postImage,
}){
    emit(SocialCreatePostLoadingState());
  PostModel model =PostModel(
     name: userModel!.name,
     image: userModel!.image,
     uId: userModel!.uId,
     text:text ,
     dateTime:dateTime ,
     postImage: postImage ?? '',
  );
    FirebaseFirestore.instance.collection('posts').add(model.toMap()).
    then((value){
        emit(SocialCreatePostSuccessState());
    }).catchError((error){
        emit(SocialCreatePostErrorState());
    });
}

void uploadPostImage({
  required String text,
  required String dateTime,
}){
  emit(SocialCreatePostLoadingState());
  firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(postImage!.path).pathSegments.last}').
  putFile(postImage!).
  then((value) {
    value.ref.getDownloadURL().then((value) {
           createPost(
            text: text, 
            dateTime: dateTime,
            postImage: value,
            );
           emit(SocialCreatePostSuccessState()); 
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }).catchError((error){});
}

void removePostImage(){
  postImage=null;
}

List<PostModel> posts=[];
List<String> postId=[];
List<int> likes=[];
void getPosts(){
  FirebaseFirestore.instance.collection('posts').get().
  then((value) 
  {
    value.docs.forEach((element) {
      element.reference.collection('likes').get().
      then((value) {
        likes.add(value.docs.length);
        postId.add(element.id);
        posts.add(PostModel.fromjson(element.data()));
      
         emit(SocialGetPostSuccessState());
      }).catchError((error){
        
      });
    });
  }).
  catchError((error){
    print(error.toString());
     emit(SocialGetPostErrorState());
  });
}

void likePost(String postId){
   FirebaseFirestore.instance.
   collection('posts').doc(postId).
   collection('likes').doc(userModel!.uId).
   set({'like':true}).
   then((value) {
      emit(SocialLikePostSuccessState());
   }).
   catchError((error){
    print(error.toString());
    emit(SocialLikePostErrorState());
   });
}
List<SocialUserModel> allUsers=[];
void getAllUsers(){
  if(allUsers.isEmpty) {
    FirebaseFirestore.instance.collection('users').get().then((value){
          value.docs.forEach((element) {
            if(element.data()['uId']!=userModel!.uId) {
              allUsers.add(SocialUserModel.fromjson(element.data()));
            } 
          });
          emit(SociaGetAllUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SociaGetAllUserErrorState());
    });
  }
}

void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
}){
  MessageModel model=MessageModel(
    senderId:userModel!.uId ,
    receiverId: receiverId,
    dateTime:dateTime ,
    text: text,
  );

  // my chat
  FirebaseFirestore.instance.
  collection('users').
  doc(userModel!.uId).
  collection('chats').
  doc(model.receiverId).
  collection('messages').
  add(model.toMap()).
  then((value) {
    emit(SocialSendMessageSuccessState());
  }).
  catchError((error){
    emit(SocialSendMessageErrorState());
  });

  // receiver chat
   FirebaseFirestore.instance.
  collection('users').
  doc(model.receiverId).
  collection('chats').
  doc(userModel!.uId).
  collection('messages').
  add(model.toMap()).
  then((value) {
    emit(SocialSendMessageSuccessState());
  }).
  catchError((error){
    emit(SocialSendMessageErrorState());
  });
}

List<MessageModel> messages=[];
void getMessage({
  required String receiverId,
}){
  FirebaseFirestore.instance.
  collection('users').
  doc(userModel!.uId).
  collection('chats').
  doc(receiverId).
  collection('messages').orderBy('dateTime').
  snapshots().listen((event) {
    messages=[];
    event.docs.forEach((element) {
      messages.add(MessageModel.fromjson(element.data()));
    });
    emit(SocialGetMessageSuccessState());
  });
}

}