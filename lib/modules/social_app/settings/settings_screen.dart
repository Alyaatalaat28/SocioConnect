import 'package:flutter/material.dart';
import 'package:flutter_applicaion/layout/social_app/cubit/cubit.dart';
import 'package:flutter_applicaion/layout/social_app/cubit/states.dart';
import 'package:flutter_applicaion/modules/social_app/editProfile/edit_profile.dart';
import 'package:flutter_applicaion/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialSettingsScreen extends StatelessWidget {
  const SocialSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[
              Container(
                height: 200.0,
                child:
                Stack(
                  alignment:AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                        alignment:AlignmentDirectional.topCenter ,
                        child:
                        Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft:Radius.circular(4) ,
                              topRight: Radius.circular(4),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('${cubit.userModel!.cover}'),
                            ),
                          ),
                        )),
                    CircleAvatar(
                      radius: 65.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                        radius: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,),
              Text(
                '${cubit.userModel!.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height:3.0,
              ),
              Text(
                '${cubit.userModel!.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child:
                        InkWell(
                          child: Column(
                            children: [
                              Text(
                                '120',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap:() {},
                        )),
                    Expanded(
                        child:InkWell(
                          child: Column(
                            children: [
                              Text(
                                '180',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap:() {},
                        )),
                    Expanded(
                        child:InkWell(
                          child: Column(
                            children: [
                              Text(
                                '120k',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap:() {},
                        )),
                    Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '64',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'following',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap:() {},
                        )),
                  ],
                ),
              ),
              Row(
                children:[
                  Expanded(
                      child:OutlinedButton(
                        onPressed: (){},
                        child: Text('Add Photos'),
                      )),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(),));
                    },
                    child: Icon(IconBroken.Edit,size:16.0,),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
