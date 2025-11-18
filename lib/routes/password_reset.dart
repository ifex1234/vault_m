import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vault_m/components/obsure_field.dart';
import 'package:vault_m/components/plain_field.dart';
import 'package:vault_m/services/auth_provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isPassword1Valid = true;
  bool _isLoading = false;

  Future<void> _passwordReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<AuthProvider>(
          context,
          listen: false,
        ).resetPassword(_emailController.text, _passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Password updated successfully, you can now sign in with your new password',
            ),
          ),
        );
        Navigator.of(context).pushReplacementNamed('/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('password reset failed: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: const Color.fromARGB(255, 252, 232, 252),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 45, top: 120),
          child: SizedBox(
            height: 500,
            width: 320,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Change Password',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),

                  PlainField2(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    validator: (value) {
                      final error = _validateEmail(value);
                      setState(() {
                        _isEmailValid = error == null;
                      });
                      return error;
                    },
                    isInputValid: _isEmailValid,
                  ),
                  SizedBox(height: 25),

                  ObscuredField2(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    validator: (value) {
                      final error = _validatePassword(value);
                      setState(() {
                        _isPasswordValid = error == null;
                      });
                      return error;
                    },
                    isInputValid: _isPassword1Valid,
                  ),
                  SizedBox(height: 25),

                  ObscuredField2(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Password',
                    validator: (value) {
                      final error = _validateConfirmPassword(value);
                      setState(() {
                        _isPassword1Valid = error == null;
                      });
                      return error;
                    },
                    isInputValid: _isPassword1Valid,
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 235, 221, 240),
                    ),
                    onPressed: _passwordReset,
                    child: Text(
                      'Change Password',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
