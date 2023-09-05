// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../login/data/create_user_model.dart';
import '../chat_details.dart';

class ChatItem extends StatelessWidget {
   ChatItem({Key? key,required this.model}) : super(key: key);
  SocialUserModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                            style: const TextStyle(
                                height: 1.4,
                                ),
                              ),
                              
                            ],
                          ),
             ),
 );
}

}