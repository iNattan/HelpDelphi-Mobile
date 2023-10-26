import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
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
                style: TextStyle(    
                  fontSize: 30      
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),            
                child: Column(                          
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Nome de usuário',
                        prefixIcon: const Icon(Icons.account_circle),
                        hintStyle: const TextStyle(
                          color: Colors.black
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ), 
                    const SizedBox(
                      height: 15,
                    ),               
                    TextField(
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      prefixIcon: const Icon(Icons.lock),
                      hintStyle: const TextStyle(
                        color: Colors.black
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
                ),   
                child: const Text('Entrar'),                       
              )
            ],
          ),
        ),
      )
    );
  }
}