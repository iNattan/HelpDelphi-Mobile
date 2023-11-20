import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo.png',
              width: 200,
              height: 200,
            ),
            const Text(
              'HelpDelphi',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Nome de usuário',
                        prefixIcon: const Icon(Icons.account_circle),
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        prefixIcon: const Icon(Icons.lock),
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await login();
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
              ),
              child: const Text('Entrar'),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> login() async {
    var url = Uri.parse('https://helpdelphi-api.fly.dev');
    var response = await http.post(url, body: {
      "username": _usernameController,
      "password": _passwordController,
    });

    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['token']);
      return true;
    }

    print(jsonDecode(response.body));
    return false;
  }
}
