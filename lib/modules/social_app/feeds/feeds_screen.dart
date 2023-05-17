import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/layout/social_app/cubit/cubit.dart';
import 'package:flutter_applicaion/shared/styles/colors.dart';
import 'package:flutter_applicaion/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../models/socialApp/post_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder: (context,state){
         return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.length>0 && SocialCubit.get(context).userModel!=null,
           builder: (context)=> SingleChildScrollView(
                 physics: const BouncingScrollPhysics(),
                 child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(8.0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    const Image(
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?w=740&t=st=1679131461~exp=1679132061~hmac=82faa8e7683e35269c88e53904b8a82d9bae6b0ffc47baa11773eb27d70c4e04'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'communicate with friends',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context,index)=>const SizedBox(height: 8.0,),
                  itemCount: SocialCubit.get(context).posts.length,),
              const SizedBox(
                height: 8.0,),
             
            ],
                 ),
               ),
           fallback:(context)=>Center(child:CircularProgressIndicator()) ,
         );
     },
    );
  }
  Widget buildPostItem(PostModel model,context,index)=>Card(
    margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
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
            padding:EdgeInsets.only(
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
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child:Row(
                children: [
                  Expanded(
                      child:InkWell(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(IconBroken.Heart,size:16.0,color:Colors.red),
                                SizedBox(width:5.0),
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
                                Icon(IconBroken.Chat,size:16.0,color:Colors.amber),
                                SizedBox(width:5.0),
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
                          SizedBox(width: 15.0,),
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
                    Icon(IconBroken.Heart,size:16.0,color:Colors.red),
                    SizedBox(width:5.0),
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
