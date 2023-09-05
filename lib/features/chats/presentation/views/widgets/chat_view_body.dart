import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/features/chats/presentation/views/widgets/chat_item.dart';
import 'package:flutter_applicaion/features/layout/manager/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layout/manager/cubit/cubit.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state){
           return ConditionalBuilder(
            condition: SocialCubit.get(context).allUsers.isNotEmpty,
             builder:(context)=> ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder:(context,index)=>ChatItem(model:SocialCubit.get(context).allUsers[index]), 
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
              ),
               itemCount: SocialCubit.get(context).allUsers.length,),
             fallback: (context)=>const Center(child: CircularProgressIndicator(),),
           );
                      
        }
    );
  }
}