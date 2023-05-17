import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/layout/social_app/cubit/cubit.dart';
import 'package:flutter_applicaion/layout/social_app/cubit/states.dart';
import 'package:flutter_applicaion/modules/social_app/newPost/new_post_screen.dart';
import 'package:flutter_applicaion/shared/components/components.dart';
import 'package:flutter_applicaion/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialNewPostState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPostScreen(),));
        }
      },
      builder: (context,state)=>Scaffold(
        appBar:AppBar(
          title:Text(SocialCubit.get(context).titles[SocialCubit.get(context).currentIndex]),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
            IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
          ],
        ),
        body:SocialCubit.get(context).screens[SocialCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: SocialCubit.get(context).currentIndex,
          onTap: (index){
            SocialCubit.get(context).changeBottomNavBar(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Paper_Upload),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Location),
              label: 'Users',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Setting),
              label: 'Settings',
            ),
          ],
        ),

      ),


    );
  }
}
