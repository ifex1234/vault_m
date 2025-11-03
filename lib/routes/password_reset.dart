import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        Navigator.of(context).pushReplacementNamed(
          '/login',
        ); // Navigate to login after successful registration
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
    return null; // Return null if the password is valid
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null; // Return null if the confirm password is valid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: ,
        title: const Text('Sign In'),
        backgroundColor: const Color.fromARGB(255, 252, 232, 252),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 45, top: 120),
        child: SizedBox(
          height: 500,
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Choose Password',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
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
              SizedBox(height: 25),
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
              SizedBox(height: 25),
              TextFormField(
                validator: (value) {
                  final error = _validateConfirmPassword(value);
                  setState(() {
                    _isPassword1Valid = error == null;
                  });
                  return error;
                },

                onSaved: (val) {
                  _confirmPasswordController.text = val!;
                },
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  filled: true,
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: _isPassword1Valid
                      ? null // Use default error border when valid
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 4.0),
                        ),
                  fillColor: const Color.fromARGB(255, 243, 229, 252),
                  suffixIcon: !_isPassword1Valid
                      ? const Icon(Icons.error, color: Colors.red)
                      : null,
                ),
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
    );
  }
}
