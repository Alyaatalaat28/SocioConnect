import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/modules/social_app/chats/chat_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/socialApp/create_user_model.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state){
           return ConditionalBuilder(
            condition: SocialCubit.get(context).allUsers.length>0,
             builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder:(context,index)=>buildChatItem(SocialCubit.get(context).allUsers[index],context), 
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
 Widget buildChatItem(SocialUserModel model,context)=> InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetailsScreen(userModel: model,)));
  },
   child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Row(
                children: [
                   CircleAvatar(
                    backgroundImage: NetworkImage('${model.image}'),
                    radius: 25.0,
                  ),
                  const SizedBox(
                    width: 12.0,),
                       Text('${model.name}',
                            style: TextStyle(
                                height: 1.4,
                                ),
                              ),
                              
                            ],
                          ),
             ),
 );
}
