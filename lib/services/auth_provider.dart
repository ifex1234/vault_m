import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:vault_m/models/customers.dart';
import 'package:vault_m/models/users.dart';
import 'package:vault_m/services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isAuthenticated = false;

  String? _token;
  User? _currentUser;
  bool _isLoading = false;
  bool _pinVerified = false;

  String? get token => _token;
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null && !JwtDecoder.isExpired(_token!);
  bool get isPinVerified => _pinVerified;

  AuthProvider() {
    _loadTokenAndUser();
  }

  Future<void> _loadTokenAndUser() async {
    _isLoading = true;
    notifyListeners();

    _token = await _storage.read(key: 'jwt_token');
    _pinVerified = false; // Reset PIN verification on app start

    if (_token != null && !JwtDecoder.isExpired(_token!)) {
      try {
        _currentUser = await _apiService.getProfile(_token!);
        // If a user with PIN logs in, they are not yet PIN verified.
        // They will be redirected to the PIN verification screen.
      } catch (e) {
        debugPrint('Failed to load user profile: $e');
        await logout(); // Logout if token is invalid or profile fetch fails
      }
    } else {
      _token = null;
      _currentUser = null;
      await _storage.delete(key: 'jwt_token');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<User> loadUser() async {
    _token = await _storage.read(key: 'jwt_token');
    if (_token != null && !JwtDecoder.isExpired(_token!)) {
      _isAuthenticated = true;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(_token!);
      final currentUser = User(
        id: decodedToken['sub'],
        email: decodedToken['email'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        firstName: decodedToken['firstName'],
        lastName: decodedToken['lastName'],
        hasPin: decodedToken['hasPin'],
      ); 
      return currentUser;
    } else {
      _token = null;
      _isAuthenticated = false;
      await _storage.delete(key: 'jwt_token');
    }
    notifyListeners();
    throw Exception('No valid token available');
  }

  // Future<void> login(String email, String password) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     final newToken = await _apiService.login(email, password);
  //     await _saveToken(newToken);
  //     _token = newToken;
  //     _currentUser = await _apiService.getProfile(_token!);
  //     _pinVerified =
  //         _currentUser?.hasPin == false; // If no pin, it's 'verified'
  //   } catch (e) {
  //     debugPrint('Login failed: $e');
  //     rethrow;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> login(String email, String password) async {
    try {
      final newToken = await _apiService.login(email, password);
      _token = newToken;
      await _storage.write(key: 'jwt_token', value: _token);
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      _token = null;
      _isAuthenticated = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String? pin,
  ) async {
    try {
      await _apiService.register(
        email,
        password,
        firstName,
        lastName,
        pin: pin,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> register(
  //   String email,
  //   String password,
  //   String firstName,
  //   String lastName, {
  //   String? pin,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     final newToken = await _apiService.register(
  //       email,
  //       password,
  //       firstName,
  //       lastName,
  //       pin: pin,
  //     );
  //     await _saveToken(newToken);
  //     _token = newToken;
  //     _currentUser = await _apiService.getProfile(_token!);
  //     _pinVerified =
  //         _currentUser?.hasPin == false; // If no pin, it's 'verified'
  //   } catch (e) {
  //     debugPrint('Registration failed: $e');
  //     rethrow;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<bool> verifyPin(String pin) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (_token == null) {
        throw Exception('No authentication token available.');
      }
      final success = await _apiService.verifyPin(_token!, pin);
      _pinVerified = success;
      return success;
    } catch (e) {
      debugPrint('PIN verification failed: $e');
      _pinVerified = false;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email, String password) async {
    try {
      await _apiService.resetPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPin(String oldPin, String newPin) async {
    try {
      await _apiService.resetPin(oldPin, newPin);
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> logout() async {
  //   _token = null;
  //   _currentUser = null;
  //   _isAuthenticated = false;
  //   await _secureStorage.delete(key: 'jwt_token');
  //   notifyListeners();
  // }
  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    _pinVerified = false; // Reset PIN verification on logout
    await _storage.delete(key: 'jwt_token');
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<Customers> addCustomer(
    String email,
    String firstName,
    String lastName,
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
    String token,
  ) async {
    try {
      final response = await _apiService.createCustomer(
        token,
        email,
        firstName,
        lastName,
        customerAddress,
        customerBusinessAddress,
        phoneNumber,
        phoneNumber2,
        BVN,
        NIN,
        // gender,
        customerDob,
        utilityBillUrl,
        identificationUrl,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
