import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/models/socialApp/create_user_model.dart';
import 'package:flutter_applicaion/shared/styles/colors.dart';
import 'package:flutter_applicaion/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_applicaion/layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/socialApp/message_model.dart';
class ChatDetailsScreen extends StatelessWidget {
    SocialUserModel userModel;
    ChatDetailsScreen({required this.userModel});
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
                  SizedBox(width: 15.0,),
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
                        return myMessageItem(SocialCubit.get(context).messages[index]);
                      }else{
                        return messageItem(SocialCubit.get(context).messages[index]);
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
  Widget messageItem(MessageModel message)=>Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                  ),
                  color: Colors.grey[300],
                ),
                child: Text('${message.text}'),
              ),
            );
 
  Widget myMessageItem(MessageModel message)=> Align(
              alignment: AlignmentDirectional.centerEnd,
               child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                  ),
                  color: default_color.withOpacity(.2),
                ),
                child: Text('${message.text}'),
                       ),
             );
}