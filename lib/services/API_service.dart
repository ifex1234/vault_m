import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vault_m/models/customers.dart';
import 'package:vault_m/models/users.dart';

class ApiService {
  // IMPORTANT:
  // For Android Emulator, use 10.0.2.2
  // For iOS Simulator, use localhost
  // For Web, use localhost
  // final String _baseUrl = 'https://vault-server-wnbz.onrender.com';
  final String _baseUrl = 'http://192.168.43.133:5347';

  // Helper for making requests with authentication
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
      // Add other methods (PUT, DELETE) as needed
      default:
        throw ArgumentError('Unsupported HTTP method: $method');
    }
  }

  // User Registration
  Future<User> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String pin,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'pin': pin,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to register');
    }
  }

  // User Login
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to log in');
    }
  }

  Future<User> resetPassword(String email, String password) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/auth/update-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'password reset failed');
    }
  }

  // Create a Customer
  Future<Customers> createCustomer(
    String firstName,
    String lastName,
    String email,
    String address,
    String otherName,
    String customerAddress,
    String customerBusinessAddress,
    int phoneNumber,
    int BVN,
    int NIN,
    String customerDOB,
    String utilityBillUrl,
    String identificationUrl,
    String creatorEmail,
    String token,
  ) async {
    final response = await _makeAuthenticatedRequest(
      'customers',
      'POST',
      token,
      body: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'address': address,
        'otherName': otherName,
        'customerAddress': customerAddress,
        'customerBusinessAddress': customerBusinessAddress,
        'phoneNumber': phoneNumber,
        'BVN': BVN,
        'NIN': NIN,
        'customerDOB': customerDOB,
        'utilityBillUrl': utilityBillUrl,
        'identificationUrl': identificationUrl,
        'creatorEmail': creatorEmail,
      },
    );

    if (response.statusCode == 201) {
      return Customers.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to create Customer');
    }
  }

  // Get My Posts
  //   Future<List<Customers>> fetchMyPosts(String token) async {
  //     final response = await _makeAuthenticatedRequest(
  //       'posts/my-posts',
  //       'GET',
  //       token,
  //     );
  //     if (response.statusCode == 200) {
  //       List<dynamic> data = jsonDecode(response.body);
  //       return data.map((json) => Post.fromJson(json)).toList();
  //     } else {
  //       final error = jsonDecode(response.body);
  //       throw Exception(error['message'] ?? 'Failed to fetch my posts');
  //     }
  //   }

  // Get All Posts (public, only published posts are returned by NestJS)
  Future<List<User>> fetchAllUsers() async {
    final response = await http.get(Uri.parse('$_baseUrl/posts'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to fetch all posts');
    }
  }
}
