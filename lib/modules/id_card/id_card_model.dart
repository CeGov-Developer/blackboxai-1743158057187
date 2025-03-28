class IdCard {
  final String id;
  final String name;
  final String photoUrl;
  final String role; // 'staff' or 'student'
  final String department;
  final DateTime expiryDate;
  final String qrData;

  IdCard({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.role,
    required this.department,
    required this.expiryDate,
    required this.qrData,
  });

  factory IdCard.fromJson(Map<String, dynamic> json) {
    return IdCard(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      role: json['role'],
      department: json['department'],
      expiryDate: DateTime.parse(json['expiryDate']),
      qrData: json['qrData'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'photoUrl': photoUrl,
    'role': role,
    'department': department,
    'expiryDate': expiryDate.toIso8601String(),
    'qrData': qrData,
  };
}