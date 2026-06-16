class Contract {
  final String id;
  final String? referenceNumber;
  final String? title;
  final String status;
  final String startDate;
  final String? endDate;

  Contract({
    required this.id,
    required this.referenceNumber,
    required this.title,
    required this.status,
    required this.startDate,
    required this.endDate,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];

    return Contract(
      id: json['id'].toString(),
      referenceNumber: attr['reference_number'],
      title: attr['title'],
      status: attr['status'],
      startDate: attr['start_date'],
      endDate: attr['end_date'],
    );
  }
}