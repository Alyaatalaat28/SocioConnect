import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/icon_broken.dart';

List<BottomNavigationBarItem>items=[
    const BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
            ),
    const BottomNavigationBarItem(
              icon: Icon(IconBroken.Chat),
              label: 'Chats',
            ),
    const BottomNavigationBarItem(
              icon: Icon(IconBroken.Paper_Upload),
              label: 'Post',
            ),
    const BottomNavigationBarItem(
              icon: Icon(IconBroken.Location),
              label: 'Users',
            ),
     const BottomNavigationBarItem(
              icon: Icon(IconBroken.Setting),
              label: 'Settings',
            ),
];