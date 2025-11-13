import 'package:vault_m/models/users.dart';

class Customers {
  final int id;
  final User? creatorId; // Nested User object
  final DateTime createdAt;
  final String email;
  final String firstName;
  final String lastName;
  final String customerAddress;
  final String customerBusinessAddress;
  final int phoneNumber;
  final int phoneNumber2;
  final int BVN;
  final int NIN;
  final String customerDOB;
  final String utilityBillUrl;
  final String identificationUrl;

  Customers({
    required this.id,
    this.creatorId,
    required this.createdAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.customerAddress,
    required this.customerBusinessAddress,
    required this.phoneNumber,
    required this.phoneNumber2,
    required this.BVN,
    required this.NIN,
    required this.customerDOB,
    required this.utilityBillUrl,
    required this.identificationUrl,
  });

  factory Customers.fromJson(Map<String, dynamic> json) {
    return Customers(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      customerAddress: json['customerAddress'],
      customerBusinessAddress: json['customerBusinessAddress'],
      phoneNumber: json['phoneNumber'],
      phoneNumber2: json['phoneNumber'],
      BVN: json['BVN'],
      NIN: json['NIN'],
      customerDOB: json['customerDOB'],
      utilityBillUrl: json['utilityBillUrl'],
      identificationUrl: json['identificationUrl'],
      creatorId: json['userId'] != null ? User.fromJson(json['userId']) : null,
    );
  }
}
