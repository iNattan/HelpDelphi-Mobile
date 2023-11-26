import 'package:projeto/http/entities/user.dart';

class Ticket {
  final String id;
  final String clientId;
  final String subject;
  final int criticality;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final User user;

  Ticket(
      {required this.id,
      required this.clientId,
      required this.subject,
      required this.criticality,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.user});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      clientId: json['clientId'],
      subject: json['subject'],
      criticality: json['criticality'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      user: User.fromJson(json['user']),
    );
  }
}
