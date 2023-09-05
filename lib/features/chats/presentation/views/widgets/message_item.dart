import 'package:flutter/material.dart';

import '../../../data/user/message_model.dart';

// ignore: must_be_immutable
class MessageItem extends StatelessWidget {
   MessageItem({Key? key,required this.message}) : super(key: key);
  MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                  ),
                  color: Colors.grey[300],
                ),
                child: Text('${message.text}'),
              ),
            );
  }
}