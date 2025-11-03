class User {
  final int id;
  final String email;
  final DateTime createdAt;
  final String firstName;
  final String lastName;
  final int pin;

  User({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.pin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      pin: json['pin'],
    );
  }
}
