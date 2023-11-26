import 'package:flutter/material.dart';
import 'package:projeto/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(1000, 7, 71, 134),
      automaticallyImplyLeading: false,
      title: Container(
        width: preferredSize.height,
        height: preferredSize.height,
        child: Image.asset(
          'assets/images/Logo.png', 
          fit: BoxFit.contain, 
        ),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              bool response = await logout();

              if (context.mounted) {
                if (response) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              }
            },
            icon: const Icon(Icons.logout))
      ],
    );
  }

  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('token');
    return true;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
