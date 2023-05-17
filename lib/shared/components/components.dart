import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaion/modules/news_app/webView/webView_screen.dart';

import 'package:flutter_applicaion/shared/cubit/cubit.dart';
import 'package:flutter_applicaion/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
   double width = double.infinity  ,
   Color background = default_color ,
  required Function function ,
  required String text ,
  bool isUpperCase = true ,
  double radius = 0.0,


}) =>  Container(
  width: width,

  // ignore: sort_child_properties_last
  child: MaterialButton(
    onPressed:() {
      function();
    } ,
    child: Text(
      isUpperCase ? text.toUpperCase() : text ,
      style: TextStyle(
        color: Colors.white,
      ),
    ),),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color:background,
  ),
);

Widget defaultFormField({
  required TextEditingController controller ,
  required TextInputType type ,
  Function? onSubmit ,
  Function? onChange ,
  required FormFieldValidator<String>? validate ,
  required String label,
  required IconData prefix ,
  VoidCallback? onTap ,
  IconData? suffix ,
  Function? suffixPressed ,

  bool isPassword = false,
  
}) => TextFormField(
controller: controller,
keyboardType: type,
obscureText: isPassword,
onFieldSubmitted:(value){

},
onChanged: (val){

},
validator: validate,
onTap:onTap,
decoration: InputDecoration(
labelText: label,
prefixIcon: Icon(
prefix,
),
suffixIcon: suffix != null ? IconButton(
  onPressed: (){
    suffixPressed!();
  } ,
  icon : Icon(
  
    suffix,
  
  ),
) : null ,
  border: OutlineInputBorder(),
),

);
Widget buildTaskItem(Map model , context) => Dismissible(
  key: Key(model['id'].toString()),
  child:Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40.0,
  
          child:Text(
  
            '${model['time']}',
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Column(
  
            mainAxisSize: MainAxisSize.min,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children: [
  
              Text(
  
                '${model['title']}',
  
                style: TextStyle(
  
                  fontSize: 18.0,
  
                  fontWeight: FontWeight.bold,
  
                ),
  
              ),
  
              Text(
  
                '${model['date']}',
  
                style: TextStyle(
  
                  color: Colors.grey,
  
                ),
  
              ),
  
            ],
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        IconButton(
  
            onPressed: (){
  
              AppCubit.get(context).updateData(
  
                  status: 'done',
  
                  id: model['id']);
  
            },
  
            icon: Icon(
  
              Icons.check_box,
  
              color: Colors.green,
  
            ),),
  
        IconButton(
  
          onPressed: (){
  
            AppCubit.get(context).updateData(
  
                status: 'archive',
  
                id: model['id']);
  
  
  
          },
  
          icon: Icon(
  
            Icons.archive,
  
            color: Colors.black45,
  
          ),),
  
  
  
      ],
  
  
  
    ),
  
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget taskBuilder({
  required List<Map> tasks ,
}) => ConditionalBuilder(
  condition: tasks.length >0 ,
  builder: (context) => ListView.separated(
      itemBuilder: (context , index) =>  buildTaskItem(tasks[index] , context),
      separatorBuilder:(context , index) => Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20.0 ,
        ),
        child: Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey,
        ),
      ),
      itemCount: tasks.length),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
        ),
        Text(
          'No Tasks Yet , Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);
Widget buildArticleItem(article , context) =>  InkWell(
    onTap:(){
      navigateTo(context,WebViewScreen(article['url']));
    } ,
    child:Padding(
padding: const EdgeInsets.all(20.0),
child: Row(
children: [
Container(
width: 120.0,
height: 120.0,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10.0),
image: DecorationImage(
image: NetworkImage('${article['urlToImage']}'),
fit:BoxFit.cover,
),

),
),
SizedBox(
width: 20.0,
),
Expanded(
child: Container(
height: 120.0,
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Expanded(
child: Text(
'${article['title']}',
style: Theme.of(context).textTheme.bodyText1,
maxLines: 3,
overflow: TextOverflow.ellipsis,
),
),
Text(
'${article['publishedAt']}',
style: TextStyle(
color: Colors.grey,
),
),

],
),
),
),
],
),
));
Widget myDivider()=> Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Container(
    height: 1.0,
    width: 1.0,
  ),
);
Widget articleBuilder (list,context,{isSearch =false})=>ConditionalBuilder(
  condition: list.length>0,
  builder:(context)=> ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=> buildArticleItem(list[index],context) ,
      separatorBuilder:(context,index)=> myDivider(),
      itemCount:list.length ),
  fallback:(context)=> isSearch? Container():Center(child: CircularProgressIndicator()),

);
void navigateTo(context,widget)=>  Navigator.push(context,
  MaterialPageRoute(
    builder: (context) => widget,
));
void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:(context)=>widget ),
        (route) => false);
void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseColor(state),
textColor: Colors.white,
fontSize: 16.0,);

enum ToastStates {SUCCESS , ERROR , WARNING}
Color chooseColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}
