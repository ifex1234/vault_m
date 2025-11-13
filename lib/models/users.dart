class User {
  final int id;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firstName;
  final String lastName;
  final bool hasPin;
  // final int pin;

  User({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    // required this.pin,
    required this.hasPin,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      // pin: json['pin'],
      hasPin: json['hasPin'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'hasPin': hasPin,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
