import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/features/feeds/presentation/views/widgets/post_item.dart';
import 'package:flutter_applicaion/features/layout/manager/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layout/manager/cubit/states.dart';

class FeedsViewBody extends StatelessWidget {
  const FeedsViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder: (context,state){
         return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel!=null,
           builder: (context)=> SingleChildScrollView(
                 physics: const BouncingScrollPhysics(),
                 child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(8.0),
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
                  itemBuilder: (context,index)=>PostItem(model:SocialCubit.get(context).posts[index],index:index),
                  separatorBuilder: (context,index)=>const SizedBox(height: 8.0,),
                  itemCount: SocialCubit.get(context).posts.length,),
              const SizedBox(
                height: 8.0,),
             
            ],
                 ),
               ),
           fallback:(context)=>const Center(child:CircularProgressIndicator()) ,
         );
     },
    );
  }
}