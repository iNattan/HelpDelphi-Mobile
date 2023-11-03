import 'package:projeto/data/models/action.dart';
import 'package:projeto/data/models/user.dart';

class TicketModel {
  final String id;
  final String clientId;
  final String subject;
  final String criticality;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ActionModel> actions;
  final UserModel user;

  TicketModel(
      {required this.id,
      required this.clientId,
      required this.subject,
      required this.criticality,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.actions,
      required this.user});

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
        id: map['id'],
        clientId: map['clientId'],
        subject: map['subject'],
        criticality: map['criticality'],
        status: map['status'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt'],
        actions: List<ActionModel>.from(map['actions'] as List),
        user: map['user']);
  }
}
