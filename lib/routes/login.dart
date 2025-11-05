import 'package:flutter/material.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vault Mobile',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
              ),

              Text(
                'Sign in',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),

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
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  final error = _validateEmail(value);
                  setState(() {
                    _isEmailValid = error == null;
                  });
                  return error;
                },

                onSaved: (val) {
                  _emailController.text = val!;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  filled: true,
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: _isEmailValid
                      ? null // Use default error border when valid
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 4.0),
                        ),
                  fillColor: const Color.fromARGB(255, 241, 223, 245),
                  suffixIcon: !_isEmailValid
                      ? const Icon(Icons.error, color: Colors.red)
                      : null,
                ),
              ),
              SizedBox(height: 5),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  final error = _validatePassword(value);
                  setState(() {
                    _isPasswordValid = error == null;
                  });
                  return error;
                },
                onSaved: (val) {
                  _passwordController.text = val!;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  filled: true,
                  suffixIcon: !_isPasswordValid
                      ? const Icon(Icons.error, color: Colors.red)
                      : null,
                  fillColor: Color.fromARGB(255, 241, 223, 245),
                  errorBorder: _isPasswordValid
                      ? null // Use default error border when valid
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 4.0),
                        ),
                ),
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
