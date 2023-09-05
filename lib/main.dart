// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/features/layout/manager/cubit/cubit.dart';
import 'package:flutter_applicaion/core/utils/bloc_observer.dart';
import 'package:flutter_applicaion/constants.dart';
import 'package:flutter_applicaion/core/utils/cubit/cubit.dart';
import 'package:flutter_applicaion/core/utils/cubit/states.dart';
import 'package:flutter_applicaion/core/utils/cache_helper.dart';
import 'package:flutter_applicaion/core/utils/styles/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/components.dart';
import 'features/layout/presentation/views/layout_view.dart';
import 'features/login/presentation/views/social_login_screen.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      print('Background Message');
      print(message.data.toString());
      showToast(text: 'Background Message', state: ToastStates.SUCCESS);
}
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
    var firebaseToken=await FirebaseMessaging.instance.getToken();
    print(firebaseToken);

    // FCM onMessage
    FirebaseMessaging.onMessage.listen((event) {
      print('on message');
      print(event.data.toString());
      showToast(text: 'on message', state: ToastStates.SUCCESS);
    });

    //FCM onMessageOpenedApp
     FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('on Message Opened App');
      print(event.data.toString());
      showToast(text: 'on Message Opened App', state: ToastStates.SUCCESS);
    });

    //FCM background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
   Bloc.observer = MyBlocObserver();
   await CacheHelper.init();
   // Use cubits...
    Widget widget;
    bool? isDark = CacheHelper.getBoolean(key: 'isDark');

   uId=CacheHelper.getData(key: 'uId');
   if(uId != null){
     widget=const SocialLayout();
   }else{
     widget=const SocialLoginScreen();
   }

  runApp( MyApp(
       isDark:isDark,
       startWidget:widget));
  }

class MyApp extends StatelessWidget {
   final bool? isDark ;
   final Widget? startWidget ;
   const MyApp({Key? key, this.isDark, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..changeAppMode(
              fromShared: isDark,)),
        BlocProvider(create:(BuildContext context)=>SocialCubit()..getUserData()..getPosts()),

      ],
      child: BlocConsumer<AppCubit,AppState>(
        listener:(context,state){
        },
        builder: (context , state){
          return  MaterialApp(
              debugShowCheckedModeBanner: false ,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,

              home:startWidget,


          );
        }
       ),
    );

  }
 }
