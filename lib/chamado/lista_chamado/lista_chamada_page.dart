import 'package:flutter/material.dart';
import 'package:projeto/chamado/abertura_chamado/abertura_chamado_page.dart';
import 'package:projeto/chamado/lista_chamado/widgets/card_chamado_widget.dart';
import 'package:projeto/chamado/widgets/app_bar_widget.dart';

class ListaChamadaPage extends StatelessWidget {
  const ListaChamadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CardChamadoWidget> cards = [
      const CardChamadoWidget(
        titulo: 'BUG',
        descricao: 'Descrição',
        status: Colors.green,
      ),
      const CardChamadoWidget(
        titulo: 'Erro',
        descricao: 'Descrição',
        status: Colors.red,
      ),
      const CardChamadoWidget(
        titulo: 'Falha',
        descricao: 'Descrição',
        status: Colors.grey,
      ),
      const CardChamadoWidget(
        titulo: 'Lorem',
        descricao: 'Descrição',
        status: Colors.yellow,
      ),
    ];
    return Scaffold(
      appBar: AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemBuilder: (context, index) => cards[index],
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: cards.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AberturaChamadoPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
