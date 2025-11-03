import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:vault_m/models/users.dart';
import 'package:vault_m/services/API_service.dart'; // You might not have the full User object after login

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String? _token;
  User? _currentUser;
  bool _isAuthenticated = false;

  String? get token => _token;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _loadTokenAndUser();
  }

  Future<void> _loadTokenAndUser() async {
    _token = await _secureStorage.read(key: 'jwt_token');
    if (_token != null && !JwtDecoder.isExpired(_token!)) {
      _isAuthenticated = true;
      // You can decode the token to get basic user info like email or id if needed
      // Map<String, dynamic> decodedToken = JwtDecoder.decode(_token!);
      // _currentUser = User(id: decodedToken['sub'], email: decodedToken['email'], createdAt: DateTime.now()); // Placeholder
    } else {
      _token = null; // Token expired or not found
      _isAuthenticated = false;
      await _secureStorage.delete(key: 'jwt_token'); // Clear invalid token
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final newToken = await _apiService.login(email, password);
      _token = newToken;
      await _secureStorage.write(key: 'jwt_token', value: _token);
      _isAuthenticated = true;
      // Optionally decode token here to set _currentUser
      notifyListeners();
    } catch (e) {
      _token = null;
      _isAuthenticated = false;
      notifyListeners();
      rethrow; // Re-throw to handle error in UI
    }
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String pin,
  ) async {
    try {
      // For registration, we just call the API. No token is returned directly.
      // After successful registration, the user usually needs to log in.
      await _apiService.register(email, password, firstName, lastName, pin);
    } catch (e) {
      rethrow; // Re-throw to handle error in UI
    }
  }

  Future<void> resetPassword(String email, String password) async {
    try {
      await _apiService.resetPassword(email, password);
    } catch (e) {
      rethrow; // Re-throw to handle error in UI
    }
  }

  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    _isAuthenticated = false;
    await _secureStorage.delete(key: 'jwt_token');
    notifyListeners();
  }
}
