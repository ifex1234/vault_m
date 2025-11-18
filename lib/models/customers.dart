import 'package:vault_m/models/users.dart';

enum Gender { male, female }

class Customers {
  final User? creatorId; // Nested User object
  final String email;
  final String firstName;
  final String lastName;
  final String customerAddress;
  final String customerBusinessAddress;
  final int phoneNumber;
  final int phoneNumber2;
  final int BVN;
  final int NIN;
  final Gender gender;
  final DateTime? customerDob;
  final String utilityBillUrl;
  final String identificationUrl;

  Customers({
    this.creatorId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.customerAddress,
    required this.customerBusinessAddress,
    required this.phoneNumber,
    required this.phoneNumber2,
    required this.BVN,
    required this.NIN,
    required this.gender,
    this.customerDob,
    required this.utilityBillUrl,
    required this.identificationUrl,
  });

  factory Customers.fromJson(Map<String, dynamic> json) {
    return Customers(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      customerAddress: json['customerAddress'],
      customerBusinessAddress: json['customerBusinessAddress'],
      phoneNumber: json['phoneNumber'],
      phoneNumber2: json['phoneNumber'],
      BVN: json['BVN'],
      NIN: json['NIN'],
      gender: json['gender'],
      customerDob: json['customerDob'] != null
          ? DateTime.parse(json['customerDob'])
          : null,
      utilityBillUrl: json['utilityBillUrl'],
      identificationUrl: json['identificationUrl'],
      creatorId: json['userId'] != null ? User.fromJson(json['userId']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'customerAddress': customerAddress,
      'customerBusinessAddress': customerBusinessAddress,
      'phoneNumber': phoneNumber,
      'phoneNumber2': phoneNumber2,
      'BVN': BVN,
      'NIN': NIN,
      // 'gender': gender,
      'customerDob': customerDob?.toIso8601String().split(
        'T',
      )[0], // Format as YYYY-MM-DD
      'utilityBillUrl': utilityBillUrl,
      'identificationUrl': identificationUrl,
      'creatorId': creatorId,
    };
  }
}
