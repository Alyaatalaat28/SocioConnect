import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/core/utils/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layout/presentation/views/layout_view.dart';
import '../../../manager/cubit/cubit.dart';
import '../../../manager/cubit/states.dart';


class SocialRegisterViewBody extends StatelessWidget {
  const SocialRegisterViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener:(context,state){
          if(state is SocialCreateUserSuccessState){
            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context)=>SocialLayout()) , (route) => false);
          }
        },
        builder: (context,state)=>Scaffold(
          appBar:AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          color:Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Register now to communicate with friends ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type:TextInputType.name,
                          validate: (String? value){
                            if(value==null || value.isEmpty){
                              return 'please enter your name';
                            }else{
                              return null;
                            }
                          },
                          label: 'user name',
                          prefix:Icons.person),

                      const SizedBox(
                        height: 15.0,
                      ),

                      defaultFormField(
                          controller: emailController,
                          type:TextInputType.emailAddress,
                          validate: (String? value){
                            if(value==null || value.isEmpty){
                              return 'please enter your email address';
                            }else{
                              return null;
                            }
                          },
                          label: 'email address',
                          prefix:Icons.email_outlined),

                      const SizedBox(
                        height: 15.0,
                      ),

                      defaultFormField(
                        controller:passwordController,
                        type:TextInputType.visiblePassword,
                        validate: (String? value){
                          if(value==null || value.isEmpty){
                            return 'password is too short';
                          }else{
                            return null;
                          }
                        },
                        label: 'password',
                        isPassword: SocialRegisterCubit.get(context).isPassword,
                        prefix:Icons.lock,
                        suffix:SocialRegisterCubit.get(context).suffix,
                        suffixPressed:(){
                          SocialRegisterCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                      defaultFormField(
                          controller: phoneController,
                          type:TextInputType.phone,
                          validate: (String? value){
                            if(value==null || value.isEmpty){
                              return 'please enter your phone';
                            }else{
                              return null;
                            }
                          },
                          label: 'phone',
                          prefix:Icons.phone),

                      const SizedBox(
                        height: 20.0,),

                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState ,
                        builder: (context)=>defaultButton(
                          function: (){
                            if(formKey.currentState!.validate()){
                              SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: 'sign up',
                          isUpperCase: true,),
                        fallback:(context)=> const Center(child: CircularProgressIndicator()),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
