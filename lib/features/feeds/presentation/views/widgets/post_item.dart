import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/colors.dart';
import '../../../../../core/utils/styles/icon_broken.dart';
import '../../../../layout/manager/cubit/cubit.dart';
import '../../../../posts/data/post_model.dart';

// ignore: must_be_immutable
class PostItem extends StatelessWidget {
   PostItem({Key? key,required this.model,required this.index}) : super(key: key);
  PostModel model;
  int index;
  @override
  Widget build(BuildContext context) {
    return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
               CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
                radius: 25.0,
              ),
              const SizedBox(
                width: 15.0,),
              Expanded(
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: const TextStyle(
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const Icon(
                            Icons.check_circle,
                            size: 16.0,
                            color: default_color,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          height: 1.4,
                        ),
                      ),

                    ],
                  )),
              const SizedBox(
                width: 5.0,),
              IconButton(
                  onPressed: (){},
                  icon:const Icon(Icons.more_horiz,
                    size: 16.0,) ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          if(model.postImage!='')
          Padding(
            padding:const EdgeInsets.only(
              top: 15.0,
            ),
          child:Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('${model.postImage}'),
              ),
            ),
          )),
         
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child:Row(
                children: [
                  Expanded(
                      child:InkWell(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                const Icon(IconBroken.Heart,size:16.0,color:Colors.red),
                                const SizedBox(width:5.0),
                                Text('${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,),
                              ],
                            )),
                        onTap: (){},
                      )),
                  Expanded(
                      child:InkWell(
                          child:Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(IconBroken.Chat,size:16.0,color:Colors.amber),
                                const SizedBox(width:5.0),
                                Text('0 comment',style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                          ),
                          onTap:(){}
                      )),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(
              bottom:10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child:InkWell(
                    child: Row(
                        children:[
                          CircleAvatar(
                            backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
                            radius: 18.0,
                          ),
                          const SizedBox(width: 15.0,),
                          Text(
                            'write a comment ...',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                            ),
                          ),
                        ]),
                    onTap: (){},
                  )),
              InkWell(
                child: Row(
                  children: [
                    const Icon(IconBroken.Heart,size:16.0,color:Colors.red),
                    const SizedBox(width:5.0),
                    Text('like',style: Theme.of(context).textTheme.caption,),
                  ],
                ),
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                },
              ),
            ],
          ),

        ],
      ),
    ),
  );
}

  
}