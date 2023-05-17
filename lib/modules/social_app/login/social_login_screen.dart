import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/layout/social_app/social_layout.dart';
import 'package:flutter_applicaion/modules/social_app/login/cubit/cubit.dart';
import 'package:flutter_applicaion/modules/social_app/login/cubit/states.dart';
import 'package:flutter_applicaion/modules/social_app/register/social_register_screen.dart';
import 'package:flutter_applicaion/shared/components/components.dart';
import 'package:flutter_applicaion/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
                  MaterialPageRoute(builder: (context)=>SocialLayout()), (route) => false);
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Login now to communicate with friends ',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
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
                  SizedBox(
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
                  SizedBox(height: 20.0,),
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
                    fallback:(context)=> Center(child: CircularProgressIndicator()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                      ),
                      TextButton(
                        onPressed: (){
                          navigateTo(context,SocialRegisterScreen());
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
