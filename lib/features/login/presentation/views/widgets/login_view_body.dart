import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/core/utils/components.dart';
import 'package:flutter_applicaion/core/utils/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layout/presentation/views/layout_view.dart';
import '../../../../register/presentation/views/social_register_screen.dart';
import '../../../manager/cubit/cubit.dart';
import '../../../manager/cubit/states.dart';


// ignore: must_be_immutable
class LoginViewBody extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginViewBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>SocialLoginCubit() ,
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state:ToastStates.ERROR);
          }
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(key: 'uId', value:state.uId ).then((value) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context)=>const SocialLayout()), (route) => false);
            });
          }
        },
        builder:(context,state)=>Scaffold(
          appBar: AppBar(),
         body:Center(
          child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      color:Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Login now to communicate with friends ',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
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
                      onSubmit:(value){
                        },
                      label: 'password',
                      isPassword: SocialLoginCubit.get(context).isPassword,
                      prefix:Icons.lock,
                      suffix:SocialLoginCubit.get(context).suffix,
                      suffixPressed:(){
                        SocialLoginCubit.get(context).changePasswordVisibility();
                      }
                  ),
                  const SizedBox(height: 20.0,),
                  ConditionalBuilder(
                    condition: state is! SocialLoginLoadingState ,
                    builder: (context)=>defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          SocialLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }

                      },
                      text: 'login',
                      isUpperCase: true,),
                    fallback:(context)=> const Center(child: CircularProgressIndicator()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account ?',
                      ),
                      TextButton(
                        onPressed: (){
                          navigateTo(context,const SocialRegisterScreen());
                        },
                        child: Text('register'.toUpperCase(),

                        ),

                      )
                    ],
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
