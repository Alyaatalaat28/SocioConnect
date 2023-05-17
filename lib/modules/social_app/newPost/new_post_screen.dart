import 'package:flutter/material.dart';
import 'package:flutter_applicaion/layout/social_app/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/states.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icon_broken.dart';
class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,state){
        var now=DateTime.now();
        var textController=TextEditingController();
      return Scaffold(
      appBar:AppBar(
        title:Text('New Post'),
        actions:[
          TextButton(
            onPressed: (){
              if(SocialCubit.get(context).postImage!=null){
                SocialCubit.get(context).uploadPostImage(
                  text: textController.text, 
                  dateTime:now.toString() );
              }else{
                SocialCubit.get(context).createPost(
                  text: textController.text,
                   dateTime: now.toString());
              }
            },
             child: const Text('POST',
             style: TextStyle(
              fontSize: 16.0,
              color: default_color,
             ),
             ),
             ),
             const SizedBox(
              width: 5.0,
             ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if(state is SocialCreatePostLoadingState)
            const LinearProgressIndicator(),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://img.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg?w=740&t=st=1679132045~exp=1679132645~hmac=010d7275ebc985e25c108c8ba6038ec01a19a746dca5fc41f271d2ff68232da2'),
                  radius: 25.0,
                ),
                const SizedBox(
                  width: 10.0,),
                Expanded(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Alyaa Talaat',
                              style: TextStyle(
                                height: 1.4,
                              ),
                            ),
                       
                          ],
                        ),
                        Text(
                          'Public',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                            height: 1.4,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Expanded(
              child: TextFormField(
                controller: textController,
                keyboardType: TextInputType.text,
                decoration:  const InputDecoration(
                  label: Text('what\'s on your mind ...'),
                  border: InputBorder.none,
                ),
              ),
            ),
            if(SocialCubit.get(context).postImage!=null)
                 Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height:140.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      image:DecorationImage(
                        fit: BoxFit.cover,
                      image: FileImage(SocialCubit.get(context).postImage!),
                     )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 15.0,
                        child: IconButton(
                          onPressed: (){
                            
                           SocialCubit.get(context).removePostImage();
                          },
                         icon:const Icon(Icons.close),iconSize:15.0 ,),
                      ),
                    )
                  ],
                 ),
            
            
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Expanded(
                 child: TextButton(
                  onPressed: (){
                    SocialCubit.get(context).getPostImage();
                  }, 
                          child:Row(
                children: [
                   const Icon(
                    IconBroken.Image,
                  ),
                  SizedBox(width: 5.0,),
                  const Text('add photos'),
                             ],)),
               ),
              Expanded(
                child: TextButton(
                  onPressed: (){}, 
                  child: const Text('#tags'),),
              )
             ],
           ),
          ]
          ),
      ),

    );
      } ,
    );
 
  }
}
