import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/colors.dart';
import '../../../data/user/message_model.dart';

// ignore: must_be_immutable
class MyMessageItem extends StatelessWidget {
 MyMessageItem({Key? key,required this.message}) : super(key: key);
  MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: AlignmentDirectional.centerEnd,
               child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                  ),
                  color: default_color.withOpacity(.2),
                ),
                child: Text('${message.text}'),
                       ),
             );

  }
}