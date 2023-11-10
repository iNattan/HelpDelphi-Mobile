import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AberturaChamadoPage extends StatefulWidget {
  const AberturaChamadoPage({super.key});

  @override
  State<AberturaChamadoPage> createState() => _AberturaChamadoPageState();
}

class _AberturaChamadoPageState extends State<AberturaChamadoPage> {
  String? criticidade;
  List<String> criticidades = ['Alta', 'Média', 'Baixa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('LOGO'),
        actions: const [
          Icon(Icons.menu),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              value: criticidade,
              borderRadius: BorderRadius.circular(15),
              items: criticidades
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text(e)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  criticidade = value;
                });
              },
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                child: const Text('Salvar'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                child: const Text('Cancelar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
