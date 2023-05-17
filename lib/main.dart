import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/layout/social_app/cubit/cubit.dart';
import 'package:flutter_applicaion/layout/social_app/social_layout.dart';
import 'package:flutter_applicaion/modules/news_app/news_app_layout/cubit/cubit.dart';
import 'package:flutter_applicaion/modules/news_app/shared/components/components.dart';
import 'package:flutter_applicaion/modules/shop_app/shop_layout/cubit/cubit.dart';
import 'package:flutter_applicaion/modules/social_app/login/social_login_screen.dart';
import 'package:flutter_applicaion/shared/bloc_observer.dart';
import 'package:flutter_applicaion/shared/components/constants.dart';
import 'package:flutter_applicaion/shared/cubit/cubit.dart';
import 'package:flutter_applicaion/shared/cubit/states.dart';
import 'package:flutter_applicaion/shared/network/local/cache_helper.dart';
import 'package:flutter_applicaion/shared/network/remote/dio_helper.dart';
import 'package:flutter_applicaion/shared/styles/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
   DioHelper.init();
   await CacheHelper.init();
   // Use cubits...
    Widget widget;
    bool? isDark = CacheHelper.getBoolean(key: 'isDark');

   uId=CacheHelper.getData(key: 'uId');
   if(uId != null){
     widget=SocialLayout();
   }else{
     widget=SocialLoginScreen();
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
