import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/features/chats/presentation/views/widgets/message_item.dart';
import 'package:flutter_applicaion/features/chats/presentation/views/widgets/my_message_item.dart';
import 'package:flutter_applicaion/features/login/data/create_user_model.dart';
import 'package:flutter_applicaion/core/utils/styles/colors.dart';
import 'package:flutter_applicaion/core/utils/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_applicaion/features/layout/manager/cubit/cubit.dart';

import '../../../layout/manager/cubit/states.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
    SocialUserModel userModel;
    ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);
    var textController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receiverId:userModel.uId!);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state)
          {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${userModel.image}'),
                  ),
                  const SizedBox(width: 15.0,),
                  Text('${userModel.name}'),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition:SocialCubit.get(context).messages.isNotEmpty ,
              builder:(context)=> Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                 Expanded(
                   child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: ((context, index) {
                      if(SocialCubit.get(context).userModel!.uId ==SocialCubit.get(context).messages[index].senderId){
                        return MyMessageItem(message:SocialCubit.get(context).messages[index]);
                      }else{
                        return MessageItem(message:SocialCubit.get(context).messages[index],);
                      }
                    }), 
                    separatorBuilder: (context,index)=>const SizedBox(
                      height: 15.0,
                    ),
                     itemCount: SocialCubit.get(context).messages.length),
                 ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                         width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                
                  ),
                  child: Row(
                     children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: TextFormField(
                             controller: textController,
                             decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'type your message here ...',
                             ),
                          ),
                        ),
                      ),
                      Container(
                        color: default_color,
                        child: MaterialButton(
                          minWidth: 1.0,
                          onPressed: (){
                            SocialCubit.get(context).sendMessage(
                              receiverId: userModel.uId!,
                               dateTime: DateTime.now().toString(),
                                text: textController.text);
                          },
                          child: const Icon(
                            IconBroken.Send,
                            color: Colors.white,
                            size: 16.0,
                          ),
                          ),
                      ),
                     ],
                  ),
                ),
                ]),
              ),
               fallback:(context)=> const Center(child: CircularProgressIndicator()),
            ),
          );},
        );
      }
    ) ;
  }
}