class ActionModel {
  final String id;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String ticketId;

  ActionModel(
      {required this.id,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.ticketId});
}
