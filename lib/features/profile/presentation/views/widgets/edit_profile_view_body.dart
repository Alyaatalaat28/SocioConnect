import  'package:flutter/material.dart';
import 'package:flutter_applicaion/features/layout/manager/cubit/cubit.dart';
import 'package:flutter_applicaion/features/layout/manager/cubit/states.dart';
import 'package:flutter_applicaion/core/utils/styles/colors.dart';
import 'package:flutter_applicaion/core/utils/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EditProfileViewBody extends StatelessWidget{
  var nameController =TextEditingController();
  var bioController =TextEditingController();

  EditProfileViewBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
       var cubit =SocialCubit.get(context);
       nameController.text=cubit.userModel!.name!;
       bioController.text=cubit.userModel!.bio!;
       var profileImage=SocialCubit.get(context).profileImage;
       var coverImage=SocialCubit.get(context).coverImage;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 5.0,
            title: const Text('Edit Profile'),
            actions: [
              TextButton(
                  onPressed: (){
                    SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                       bio: bioController.text);
                  },
                  child: Text('update'.toUpperCase(),
                    style: const TextStyle(color: default_color),)),
                    const SizedBox(
                      width:15.0,),
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child:SingleChildScrollView(
            child: Column(
              children: [
                if (state is SocialUpdateLoadingState)
                const LinearProgressIndicator(),
                if (state is SocialUpdateLoadingState)
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 200.0,
                  child:
                  Stack(
                    alignment:AlignmentDirectional.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                              alignment:AlignmentDirectional.topCenter ,
                              child:
                              Container(
                                width: double.infinity,
                                height: 140.0,
                                decoration: BoxDecoration(
                                  borderRadius:const BorderRadius.only(
                                    topLeft:Radius.circular(4) ,
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:(coverImage==null? NetworkImage('${cubit.userModel!.cover}'):FileImage(coverImage))as ImageProvider,
                                  ),
                                ),
                              )),
                              Padding(
                              padding:const EdgeInsets.only(
                                top: 5.0,
                                right: 5.0,
                              ),
                    
                          child:IconButton(
                            onPressed: (){
                              SocialCubit.get(context).getCoverImage();
                            },
                          icon:const CircleAvatar(
                            child: Icon(
                              IconBroken.Camera,
                              size:16.0,
                            ),
                          ))),
                          ]),
                      Stack(
                          alignment:AlignmentDirectional.bottomEnd,
                        children:[
                      CircleAvatar(
                            radius: 65.0,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              backgroundImage:(profileImage == null ? NetworkImage(cubit.userModel!.image!):FileImage(profileImage))as ImageProvider,
                              radius: 62.0,
                            ),
                          ),
                          IconButton(onPressed: (){
                            SocialCubit.get(context).getProfileImage();
                          },
                         icon:const CircleAvatar(  
                               child: Icon(
                              IconBroken.Camera,
                              size:16.0,
                            ),
                          )),
                        ]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,),
                  if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                  Row(
                    children: [
                      if(SocialCubit.get(context).profileImage!=null)
                      Expanded(
                    child:  Column(
                        children: [
                          Container(
                            color: default_color,
                            height:50.0,
                            width: double.infinity,
                            child: TextButton(
                              child:const Text('Update Profile',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              ),
                              onPressed: (){
                                  SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text, 
                                    bio: bioController.text);
                              },
                              ),
                          ),
                           const SizedBox(
                            height: 5.0,
                          ),
                          if(state is SocialUpdateLoadingState)
                          const LinearProgressIndicator(),
                          if(state is SocialUpdateLoadingState)
                          const SizedBox(
                            height: 20.0,
                          ),
                        ]),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if(SocialCubit.get(context).coverImage!=null)
                      Expanded(
                      child:  Column(
                        children: [
                          Container(
                            color: default_color,
                            height:50.0,
                            width: double.infinity,
                            child: TextButton(
                              child:const Text('Update Cover',
                               style: TextStyle(
                                color: Colors.white,
                               ),
                              ),
                              onPressed: (){
                                  SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text, 
                                    bio: bioController.text);
                              },
                              ),
                          ),
                          if(state is SocialUpdateLoadingState)
                           const SizedBox(
                            height: 5.0,
                          ),
                          if(state is SocialUpdateLoadingState)
                          const LinearProgressIndicator(),
                          
                        ])),
                      
                    ]
                  ),
                  if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                  const SizedBox(
                    height: 20.0,
                  ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'value must not be empty';
                    }else{
                      return null;
                    }
                  },
                  decoration:const InputDecoration(
                    label: Text('name'),
                    prefixIcon: Icon(
                      IconBroken.User,
                    ),
                    border: OutlineInputBorder()
                  ),
                  ),
                const SizedBox(
                  height:10.0,),
                TextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'value must not be empty';
                    }else{
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text('bio'),
                      prefixIcon: Icon(
                        IconBroken.Info_Circle,
                      ),
                      border: OutlineInputBorder()
                  ),
                ),
              ],
            )
            ),
          ),
        );
      },
    );
  }
}