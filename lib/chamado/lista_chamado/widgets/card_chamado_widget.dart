import 'package:flutter/material.dart';
import 'package:projeto/chamado/abertura_chamado/abertura_chamado_page.dart';

class CardChamadoWidget extends StatelessWidget {
  final String titulo;
  final String descricao;
  final Color status;

  const CardChamadoWidget(
      {super.key,
      required this.titulo,
      required this.descricao,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: Text(descricao)),
              const SizedBox(
                width: 8,
              ),
              Container(
                width: 20,
                height: 20,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: status),
              )
            ],
          )
        ],
      ),
    );
  }
}
