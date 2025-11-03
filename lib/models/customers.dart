import 'package:vault_m/models/users.dart';

class Customers {
  final int id;
  final User? userId; // Nested User object
  final DateTime createdAt;
  final String email;
  final String address;
  final String firstName;
  final String lastName;
  final String otherName;
  final String customerAddress;
  final String customerBusinessAddress;
  final int phoneNumber;
  final int BVN;
  final int NIN;
  final String customerDOB;
  final String utilityBillUrl;
  final String identificationUrl;
  final String creatorEmail;

  Customers({
    required this.id,
    this.userId,
    required this.createdAt,
    required this.email,
    required this.address,
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.customerAddress,
    required this.customerBusinessAddress,
    required this.phoneNumber,
    required this.BVN,
    required this.NIN,
    required this.customerDOB,
    required this.utilityBillUrl,
    required this.identificationUrl,
    required this.creatorEmail,
  });

  factory Customers.fromJson(Map<String, dynamic> json) {
    return Customers(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      email: json['email'],
      address: json['address'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      otherName: json['otherName'],
      customerAddress: json['customerAddress'],
      customerBusinessAddress: json['customerBusinessAddress'],
      phoneNumber: json['phoneNumber'],
      BVN: json['BVN'],
      NIN: json['NIN'],
      customerDOB: json['customerDOB'],
      utilityBillUrl: json['utilityBillUrl'],
      identificationUrl: json['identificationUrl'],
      creatorEmail: json['creatorEmail'],
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
    );
  }
}
