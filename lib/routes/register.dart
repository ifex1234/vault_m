import 'package:flutter/material.dart';
import 'package:vault_m/components/obsure_field.dart';
import 'package:vault_m/components/plain_field.dart';
import 'package:vault_m/routes/login.dart';
import 'package:vault_m/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 70),
        child: SizedBox(
          height: 900,
          width: 320,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Welcome to Vault Mobile',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),

                FormWidget(),
              ],
            ),
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
  bool _isNameValid = true;
  bool _isPinValid = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isPasswordValid = true;
  bool _isLoading = false;
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<AuthProvider>(context, listen: false).register(
          _emailController.text,
          _passwordController.text,
          _firstNameController.text,
          _lastNameController.text,
          _pinController.text.isNotEmpty ? _pinController.text : null,
        );

        Navigator.of(context).pushReplacementNamed('/login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Registration successful!, Kindly log in with your new details',
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
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

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    final int length = 4;
    if (value.length < length) {
      return 'name must be at least $length characters long';
    }
    return null;
  }

  String? _validatePin(String? value) {
    {
      if (value != null && value.isNotEmpty) {
        if (value.length != 4 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'PIN must be exactly 4 digits';
        }
      }
      return null;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _pinController.dispose();
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
              Text(
                'Register to get started',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 15),

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
              SizedBox(height: 5),

              PlainField(
                controller: _firstNameController,
                labelText: 'First name',
                hintText: 'Enter your first name',
                validator: (value) {
                  final error = _validateName(value);
                  setState(() {
                    _isNameValid = error == null;
                  });
                  return error;
                },
                isInputValid: _isNameValid,
              ),
              SizedBox(height: 5),

              PlainField(
                controller: _lastNameController,
                labelText: 'Last name',
                hintText: 'Enter your last name',
                validator: (value) {
                  final error = _validateName(value);
                  setState(() {
                    _isNameValid = error == null;
                  });
                  return error;
                },
                isInputValid: _isNameValid,
              ),
              SizedBox(height: 5),
              ObscuredField2(
                controller: _pinController,
                labelText: 'Pin',
                hintText: "enter pin",
                validator: (value) {
                  final error = _validatePin(value);
                  setState(() {
                    _isPinValid = error == null;
                  });
                  return error;
                },
                isInputValid: _isPinValid,
              ),
              SizedBox(height: 12),
              ObscuredField2(
                controller: _passwordController,
                labelText: 'password',
                hintText: 'Enter your password',
                validator: (value) {
                  if (value != null && value.isEmpty == false) {
                    return null;
                  } else if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return 'Not a valid password.';
                },
                isInputValid: _isPasswordValid,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                _register();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 50),
                                elevation: 2,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  245,
                                  215,
                                  250,
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 73, 3, 85),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        InkWell(
                          child: Text('Log in', style: TextStyle(fontSize: 16)),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          ),
                        ),
                      ],
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
