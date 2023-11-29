class Ticket {
  final String id;
  final String clientId;
  final int number;
  final String subject;
  final String description;
  final int criticality;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Ticket({
    required this.id,
    required this.clientId,
    required this.number,
    required this.subject,
    required this.description,
    required this.criticality,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      clientId: json['clientId'],
      number: json['number'],
      subject: json['subject'],
      description: json['description'],
      criticality: json['criticality'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
