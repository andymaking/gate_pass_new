class VisitorPass {
  final String userId;
  final String id;
  final String locationId;
  final DateTime startTime;
  final DateTime endTime;
  final String purpose;
  final String address;
  final String passKey;
  final List<VisitUser> visitors;

  VisitorPass({
    required this.userId,
    required this.locationId,
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.purpose,
    required this.address,
    required this.passKey,
    required this.visitors,
  });

  factory VisitorPass.fromJson(Map<String, dynamic> json) {
    return VisitorPass(
      userId: json['userId'],
      id: json['id'],
      locationId: json['locationId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      purpose: json['purpose'],
      address: json['address'],
      passKey: json['passKey'],
      visitors: (json['visitors'] as List<dynamic>)
          .map((v) => VisitUser.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'locationId': locationId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'purpose': purpose,
      'address': address,
      'passKey': passKey,
      'visitors': visitors.map((v) => v.toJson()).toList(),
    };
  }
}

class VisitUser {
  final String fullName;
  final String email;
  final String phoneNumber;

  VisitUser({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  factory VisitUser.fromJson(Map<String, dynamic> json) {
    return VisitUser(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}