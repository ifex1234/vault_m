import 'package:flutter/material.dart';
import 'package:vault_m/components/obsure_field.dart';
import 'package:vault_m/components/plain_field.dart';
import 'package:vault_m/routes/login.dart';
import 'package:vault_m/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

// class FormData {
//   final String email;
//   final String password;
//   final String firstName;
//   final String lastName;
//   final String pin;

//   const FormData({
//     required this.password,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.pin,
//   });

//   factory FormData.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'email': String email,
//         'password': String password,
//         'firstName': String firstName,
//         'lastName': String lastName,
//         'pin': dynamic pin,
//       } =>
//         FormData(
//           email: email,
//           password: password,
//           firstName: firstName,
//           lastName: lastName,
//           pin: pin?.toString() ?? '',
//         ),
//       _ => throw const FormatException('Failed to load FormData.'),
//     };
//   }
// }

// Future<FormData> createUser(
//   String title,
//   String firstName,
//   String lastName,
//   String email,
//   String pin,
// ) async {
//   final response = await http.post(
//     Uri.parse('http://192.168.43.133:5347/auth/register'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'pin': pin,
//     }),
//   );

//   if (response.statusCode == 201) {
//     print('Server Response Body: ${response.body}');
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return FormData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception(
//       'Failed to create user. Status Code: ${response.statusCode}, Body: ${response.body}',
//     ); // More info on error
//   }
// }

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Registration Page')),
      body: Padding(
        padding: const EdgeInsets.only(left: 45, top: 70),
        child: SizedBox(
          height: 900,
          width: 320,
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
  bool _isPasswordValid = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _pinController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  // bool _isPasswordValid = true;
  // bool _obscurePassword = true;
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
          _pinController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.of(context).pushReplacementNamed(
          '/home',
        ); // Navigate to welcome page after successful registration
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
    // Basic email validation regex
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null; // Return null if the email is valid
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    final int length = 4;
    if (value.length < length) {
      return 'name must be at least $length characters long';
    }
    return null; // Return null if the name is valid
  }

  String? _validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your pin';
    }
    // Basic email validation regex
    final int length = 4;
    if (value.length < length || value.length > length) {
      return 'pin must be $length digits';
    }
    return null; // Return null if the pin is valid
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // _confirmPasswordController.dispose();
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
