import 'dart:convert';

import 'package:projeto/data/http/exceptions.dart';
import 'package:projeto/data/http/http_client.dart';
import 'package:projeto/data/models/ticket.dart';

abstract class ITicketsRepository {
  Future<List<TicketModel>> getTickets();
}

class TicketRepository implements ITicketsRepository {
  final IHttpClient client;

  TicketRepository({required this.client});

  @override
  Future<List<TicketModel>> getTickets() async {
    final response = await client.get(
      url: 'https://helpdelphi-api.fly.dev',
    );

    if (response.statusCode == 200) {
      final List<TicketModel> tickets = [];

      final body = jsonDecode(response.body);

      body['items'].map((item) {
        final TicketModel ticket = TicketModel.fromMap(item);
        tickets.add(ticket);
      }).toList();

      return tickets;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada está incorreta');
    } else {
      throw Exception('Não foi possível carregar os chamados');
    }
  }
}
