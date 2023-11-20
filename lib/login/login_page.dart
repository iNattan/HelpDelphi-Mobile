import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/chamado/lista_chamado/lista_chamada_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    super.initState();
    verifyToken().then((value) => {
          if (value)
            {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListaChamadaPage()))
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        validator: (username) {
                          if (username == null || username.isEmpty) {
                            return 'Por favor, digite seu usuario';
                          }
                          return null;
                        },
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
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Por favor, digite sua senha';
                          }
                          return null;
                        },
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
                ElevatedButton(
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (_formKey.currentState!.validate()) {
                      bool response = await login();
                      if (currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      if (mounted) {
                        if (response) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ListaChamadaPage()));
                        }
                      }
                    }
                    ;
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 50),
                  ),
                  child: const Text('Entrar'),
                )
              ],
            ),
          )),
    );
  }

  Future<bool> verifyToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('http://localhost:3333/users/session');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": _usernameController.text,
          "password": _passwordController.text,
        }));

    if (response.statusCode == 200) {
      String token = jsonDecode(response.body)['token'];
      await sharedPreferences.setString('token', token);
      return true;
    }

    return false;
  }
}
