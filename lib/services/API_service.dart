import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vault_m/models/customers.dart';
import 'package:vault_m/models/users.dart';
import 'package:flutter/material.dart';

class ApiService {
  // IMPORTANT:
  // For Android Emulator, use 10.0.2.2
  // For Web, use localhost
  //final String _baseUrl = 'https://vault-server-w33c.onrender.com';
  final String _baseUrl = 'http://192.168.43.133:55431';

  Future<http.Response> _makeAuthenticatedRequest(
    String endpoint,
    String method,
    String? token, {
    Map<String, dynamic>? body,
  }) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final encodedBody = body != null ? jsonEncode(body) : null;

    switch (method.toUpperCase()) {
      case 'GET':
        return http.get(url, headers: headers);
      case 'POST':
        return http.post(url, headers: headers, body: encodedBody);
      // To add other methods (PUT, DELETE) as needed
      default:
        throw ArgumentError('Unsupported HTTP method: $method');
    }
  }

  Future<Map<String, dynamic>> _post(
    String endpoint,
    Map<String, dynamic> data, {
    String? token,
  }) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to perform operation');
    }
  }

  Future<Map<String, dynamic>> _get(String endpoint, {String? token}) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to fetch data');
    }
  }

  // User Registration
  // Future<User> register(
  //   String email,
  //   String password,
  //   String firstName,
  //   String lastName,
  //   String pin,
  // ) async {
  //   final response = await http.post(
  //     Uri.parse('$_baseUrl/auth/register'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'email': email,
  //       'password': password,
  //       'firstName': firstName,
  //       'lastName': lastName,
  //       'pin': pin,
  //     }),
  //   );

  //   if (response.statusCode == 201) {
  //     // return User.fromJson(jsonDecode(response.body));
  //     final data = jsonDecode(response.body);
  //     return data['message'];
  //   } else {
  //     final error = jsonDecode(response.body);
  //     //throw Exception(error['message'] ?? 'Failed to register');
  //     throw Exception(
  //       'Failed to create user. Status Code: ${response.statusCode}, Body: ${response.body}',
  //     );
  //   }
  // }

  Future<String> register(
    String email,
    String password,
    String firstName,
    String lastName, {
    String? pin,
  }) async {
    final Map<String, dynamic> body = {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
    if (pin != null && pin.isNotEmpty) {
      body['pin'] = pin;
    }
    final responseData = await _post('auth/register', body);
    return responseData['access_token'];
  }

  // Future<String> login(String email, String password) async {
  //   final responseData = await _post('auth/login', {
  //     'email': email,
  //     'password': password,
  //   });
  //   return responseData['access_token'];
  // }

  // User Login
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to log in');
    }
  }

  Future<String> resetPassword(String email, String password) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['messagewww'] ?? 'password reset failed');
    }
  }

  Future<User> resetPin(String oldPin, String newPin) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/auth/update-pin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'oldPin': oldPin, 'newPin': newPin}),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'pin reset failed');
    }
  }

  Future<User> getProfile(String token) async {
    final responseData = await _makeAuthenticatedRequest(
      'auth/profile',
      'GET',
      token,
    );
    return User.fromJson(responseData as Map<String, dynamic>);
  }

  // Future<User> getProfile2(String token) async {
  //   final responseData = await _get('auth/profile', token: token);
  //   return User.fromJson(responseData);
  // }

  Future<bool> verifyPin(String token, String pin) async {
    try {
      final responseData = await _post('auth/verify-pin', {
        'pin': pin,
      }, token: token);
      return responseData['success'] == true;
    } catch (e) {
      debugPrint('PIN verification failed: $e');
      return false;
    }
  }

  Future<Customers> createCustomer(
    String token,
    String firstName,
    String lastName,
    String email,
    String customerAddress,
    String customerBusinessAddress,
    int phoneNumber,
    int phoneNumber2,
    int BVN,
    int NIN,
    // Gender gender,
    DateTime customerDob,
    String utilityBillUrl,
    String identificationUrl,
  ) async {
    final responseData = await _post('customers/create-customer', {
      'title': firstName,
      'content': lastName,
      'lastName': lastName,
      'email': email,
      'customerAddress': customerAddress,
      'customerBusinessAddress': customerBusinessAddress,
      'phoneNumber': phoneNumber,
      'phoneNumber2': phoneNumber2,
      'BVN': BVN,
      'NIN': NIN,
      // 'gender': gender,
      'customerDob': customerDob,
      'utilityBillUrl': utilityBillUrl,
      'identificationUrl': identificationUrl,
    }, token: token);
    return Customers.fromJson(responseData);
  }

  // Create a Customer
  // Future<Customers> createCustomer(
  //   String firstName,
  //   String lastName,
  //   String email,
  //   String customerAddress,
  //   String customerBusinessAddress,
  //   int phoneNumber,
  //   int phoneNumber2,
  //   int BVN,
  //   int NIN,
  //   DateTime customerDOB,
  //   String utilityBillUrl,
  //   String identificationUrl,
  //   final User? creatorId,
  //   String token,
  // ) async {
  //   final response = await _makeAuthenticatedRequest(
  //     'customers/create-customer',
  //     'POST',
  //     token,
  //     body: {
  //       'firstName': firstName,
  //       'lastName': lastName,
  //       'email': email,
  //       'customerAddress': customerAddress,
  //       'customerBusinessAddress': customerBusinessAddress,
  //       'phoneNumber': phoneNumber,
  //       'phoneNumber2': phoneNumber2,
  //       'BVN': BVN,
  //       'NIN': NIN,
  //       'customerDOB': customerDOB,
  //       'utilityBillUrl': utilityBillUrl,
  //       'identificationUrl': identificationUrl,
  //       'creatorId': creatorId,
  //     },
  //   );

  //   if (response.statusCode == 201) {
  //     return Customers.fromJson(jsonDecode(response.body));
  //   } else {
  //     final error = jsonDecode(response.body);
  //     throw Exception(error['message'] ?? 'Failed to create Customer');
  //   }
  // }

  Future<List<Customers>> fetchCustomers(String token, int id) async {
    final response = await _makeAuthenticatedRequest(
      'customers/user/$id',
      'GET',
      token,
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Customers.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to fetch cutomers');
    }
  }

  // Future<List<User>> fetchAllUsers() async {
  //   final response = await http.get(Uri.parse('$_baseUrl/auth/users'));

  //   if (response.statusCode == 200) {
  //     List<dynamic> data = jsonDecode(response.body);
  //     return data.map((json) => User.fromJson(json)).toList();
  //   } else {
  //     final error = jsonDecode(response.body);
  //     throw Exception(error['message'] ?? 'Failed to fetch all users');
  //   }
  // }

  Future<User?> getUserDetails(String s) async {
    final response = await _makeAuthenticatedRequest('auth/profile', 'GET', s);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to fetch user details');
    }
  }
}
