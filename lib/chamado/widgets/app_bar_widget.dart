import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({super.key})
      : super(
          automaticallyImplyLeading: false,
          title: const Text('LOGO'),
          actions: const [
            Icon(Icons.menu),
          ],
        );
}
