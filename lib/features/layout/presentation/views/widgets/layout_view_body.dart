
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/features/layout/manager/cubit/states.dart';
import 'package:flutter_applicaion/features/layout/presentation/views/widgets/bottom_nav_list_of_items.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles/icon_broken.dart';
import '../../../../posts/presentation/views/new_post_screen.dart';
import '../../../manager/cubit/cubit.dart';


class LayoutViewBody extends StatelessWidget {
  const LayoutViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialNewPostState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const NewPostScreen(),));
        }
      },
      builder: (context,state)=>Scaffold(
        appBar:AppBar(
          title:Text(SocialCubit.get(context).titles[SocialCubit.get(context).currentIndex]),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(IconBroken.Notification)),
            IconButton(onPressed: (){}, icon: const Icon(IconBroken.Search)),
          ],
        ),
        body:SocialCubit.get(context).screens[SocialCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: SocialCubit.get(context).currentIndex,
          onTap: (index){
            SocialCubit.get(context).changeBottomNavBar(index);
          },
          items: items,
           
        ),

      ),


    );
  }
}
