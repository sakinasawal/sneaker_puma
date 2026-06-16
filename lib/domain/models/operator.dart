class Operator {
  final String id;
  final String name;

  Operator({
    required this.id,
    required this.name,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'] ?? {};

    return Operator(
      id: json['id'].toString(),
      name: attr['name'] ?? '',
    );
  }
}