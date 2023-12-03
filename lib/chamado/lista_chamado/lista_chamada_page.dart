import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto/chamado/abertura_chamado/abertura_chamado_page.dart';
import 'package:projeto/chamado/lista_chamado/widgets/card_chamado_widget.dart';
import 'package:projeto/chamado/widgets/app_bar_widget.dart';
import 'package:projeto/http/entities/ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListaChamadoPage extends StatefulWidget {
  const ListaChamadoPage({super.key});

  @override
  State<ListaChamadoPage> createState() => _ListaChamadoState();
}

class _ListaChamadoState extends State<ListaChamadoPage> {
  late Future<List<Ticket>> futureTickets;

  @override
  void initState() {
    super.initState();
    futureTickets = getTickets();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      futureTickets = getTickets();
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Container(
          margin: const EdgeInsets.only(bottom: 60),
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<Ticket>>(
                future: futureTickets,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Ticket> tickets = snapshot.data!;
                    return ListView.builder(
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final Ticket ticket = tickets[index];
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          child: CardChamadoWidget(
                            titulo: ticket.subject,
                            descricao: ticket.description,
                            status: getStatusColor(ticket.status),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
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

  Future<List<Ticket>> getTickets() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://helpdelphi-api.fly.dev/tickets/me');
    final response = await http.get(url, headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List lista = body['items'];
      return lista.map((e) => Ticket.fromJson(e)).toList();
    }

    throw Exception('Failed to load tickets');
  }
}

class GetTicketsResponse {
  final List<Ticket> items;

  GetTicketsResponse({
    required this.items,
  });
}

MaterialColor getStatusColor(String status) {
  switch (status) {
    case 'waiting':
      {
        return Colors.grey;
      }
    case 'in_progress':
      {
        return Colors.blue;
      }
    case 'finished':
      {
        return Colors.green;
      }
    case 'stopped':
      {
        return Colors.red;
      }
  }

  throw Exception('Status not found');
}
