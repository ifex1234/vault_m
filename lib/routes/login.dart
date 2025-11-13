// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vault_m/components/obsure_field.dart';
import 'package:vault_m/components/plain_field.dart';
import 'package:vault_m/routes/password_reset.dart';
import 'package:vault_m/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 45, top: 70),
        child: SizedBox(
          height: 700,
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Vault Mobile',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Text(
                'Sign in',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),

              FormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<AuthProvider>(
          context,
          listen: false,
        ).login(_emailController.text, _passwordController.text);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Successfully logged in')));
        Navigator.of(context).pushReplacementNamed('/welcome');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('login failed: ${e.toString()}')),
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
    return null; // Return null if the password is valid
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: SizedBox(
          height: 540,
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PlainField(
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
                isInputValid: _isPasswordValid,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                _login();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(100, 50),
                                elevation: 2,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  245,
                                  215,
                                  250,
                                ),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 73, 3, 85),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),

                    InkWell(
                      child: Text(
                        'I forgot my password',
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
