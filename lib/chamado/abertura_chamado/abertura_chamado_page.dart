import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto/chamado/lista_chamado/lista_chamada_page.dart';
import 'package:projeto/chamado/widgets/app_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AberturaChamadoPage extends StatefulWidget {
  const AberturaChamadoPage({super.key});

  @override
  State<AberturaChamadoPage> createState() => _AberturaChamadoPageState();
}

class _AberturaChamadoPageState extends State<AberturaChamadoPage> {
  List<String> criticidades = ['Baixa', 'Média', 'Alta'];
  String _selectedCriticidade = 'Baixa';
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _assuntoController = TextEditingController();
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text('Abertura de chamados - N°5',
                    style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _assuntoController,
                  keyboardType: TextInputType.text,
                  validator: (assunto) {
                    if (assunto == null || assunto.isEmpty) {
                      return 'Por favor, digite o assunto do chamado';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Assunto*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelStyle: const TextStyle(fontSize: 20),
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descricaoController,
                  keyboardType: TextInputType.text,
                  validator: (descricao) {
                    if (descricao == null || descricao.isEmpty) {
                      return 'Por favor, digite uma descrição do chamado';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Descrição*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelStyle: const TextStyle(fontSize: 20),
                  ),
                  style: const TextStyle(fontSize: 20),
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Criticidade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelStyle: const TextStyle(fontSize: 20),
                  ),
                  isExpanded: true,
                  value: _selectedCriticidade,
                  borderRadius: BorderRadius.circular(15),
                  items: criticidades
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text(e)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCriticidade = value as String;
                    });
                  },
                ),
              ],
            ),
          )),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(              
              onPressed: _isButtonDisabled ? null : () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isButtonDisabled = true;
                  });
                bool response = await createTicket();
                if (currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                if (mounted) {
                  if (response) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListaChamadoPage(),
                      ),
                    );
                  }
                }
              }
            },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: 30
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),                
                ),
              ),
              child: const Text('Salvar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: 30
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),                
                ),
              ),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> createTicket() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final url = Uri.parse('https://helpdelphi-api.fly.dev/tickets');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          'subject': _assuntoController.text,
          'description': _descricaoController.text,
          'status': 'waiting',
          'criticality': getCriticality(_selectedCriticidade),
        }));

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }
}

int getCriticality(String criticality) {
  switch (criticality) {
    case 'Baixa':
      {
        return 1;
      }
    case 'Média':
      {
        return 2;
      }
    case 'Alta':
      {
        return 3;
      }
    default:
      {
        return 1;
      }
  }
}
