import 'package:flutter/material.dart';
import 'package:vault_m/routes/login.dart';
import 'package:vault_m/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

// class FormData {
//   final String email;
//   final String password;
//   final String firstName;
//   final String lastName;
//   final int pin;

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
//         'pin': int pin,
//       } =>
//         FormData(
//           email: email,
//           password: password,
//           firstName: firstName,
//           lastName: lastName,
//           pin: pin,
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
//   int pin,
// ) async {
//   final response = await http.post(
//     Uri.parse('https://vault-server-wnbz.onrender.com/auth/register'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'pin': pin.toString(),
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return FormData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create user.');
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vault Mobile',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
              ),

              Text(
                'Register to get started',
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
  bool _isNameValid = true;
  bool _isPinValid = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _pinController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  // bool _isPasswordValid = true;
  // bool _obscurePassword = true;

  // void _submit() {
  //   final form = _formKey.currentState;
  //   if (form != null && form.validate()) {
  //     form.save();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Account with email $_email and $_password signed in'),
  //       ),
  //     );
  //   }
  // }

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
          const SnackBar(
            content: Text('Registration successful! Please log in.'),
          ),
        );
        Navigator.of(context).pushReplacementNamed(
          '/home',
        ); // Navigate to login after successful registration
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

  // Future<FormData> createUser() async {
  //   final response = await http.post(
  //     Uri.parse('https://vault-server-wnbz.onrender.com/auth/register'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'password': _passwordController.text,
  //       'firstName': _firstNameController.text,
  //       'lastName': _lastNameController.text,
  //       'email': _emailController.text,
  //       'pin': _pinController.text,
  //     }),
  //   );

  //   if (response.statusCode == 201) {
  //     // If the server did return a 201 CREATED response,
  //     // then parse the JSON.
  //     return FormData.fromJson(
  //       jsonDecode(response.body) as Map<String, dynamic>,
  //     );
  //   } else {
  //     // If the server did not return a 201 CREATED response,
  //     // then throw an exception.
  //     throw Exception('Failed to create user.');
  //   }
  // }

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
                controller: _firstNameController,
                validator: (value) {
                  final error = _validateName(value);
                  setState(() {
                    _isNameValid = error == null;
                  });
                  return error;
                },

                onSaved: (val) {
                  _firstNameController.text = val!;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your first name',
                  labelText: 'First Name',
                  filled: true,
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: _isNameValid
                      ? null // Use default error border when valid
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 4.0),
                        ),
                  fillColor: const Color.fromARGB(255, 241, 223, 245),
                  suffixIcon: !_isNameValid
                      ? const Icon(Icons.error, color: Colors.red)
                      : null,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _lastNameController,
                validator: (value) {
                  final error = _validateName(value);
                  setState(() {
                    _isNameValid = error == null;
                  });
                  return error;
                },

                onSaved: (val) {
                  _lastNameController.value = val! as TextEditingValue;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your last name',
                  labelText: 'Last Name',
                  filled: true,
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: _isNameValid
                      ? null // Use default error border when valid
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 4.0),
                        ),
                  fillColor: const Color.fromARGB(255, 241, 223, 245),
                  suffixIcon: !_isNameValid
                      ? const Icon(Icons.error, color: Colors.red)
                      : null,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _pinController,
                obscureText: true,
                validator: (value) {
                  final error = _validatePin(value);
                  setState(() {
                    _isPinValid = error == null;
                  });
                  return error;
                },

                onSaved: (val) {
                  _pinController.text = val!;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your pin',
                  labelText: 'Pin',
                  filled: true,
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: _isPinValid
                      ? null // Use default error border when valid
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 4.0),
                        ),
                  fillColor: const Color.fromARGB(255, 241, 223, 245),
                  suffixIcon: !_isPinValid
                      ? const Icon(Icons.error, color: Colors.red)
                      : null,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value != null && value.isEmpty == false) {
                    return null;
                  } else if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return 'Not a valid password.';
                },
                onSaved: (val) {
                  _passwordController.text = val!;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  filled: true,
                  fillColor: Color.fromARGB(255, 241, 223, 245),
                ),
              ),
              // TextFormField(
              //   obscureText: _obscurePassword, // Control text obscuring
              //   decoration: InputDecoration(
              //     labelText: 'Password',
              //     hintText: 'Enter your password',
              //     border: const OutlineInputBorder(),
              //     // Error icon for password field
              //     suffixIcon: Row(
              //       mainAxisSize: MainAxisSize.min, // Keep row tight
              //       children: [
              //         if (!_isPasswordValid)
              //           const Icon(Icons.error, color: Colors.red),
              //         // Toggle password visibility icon
              //         IconButton(
              //           icon: Icon(
              //             _obscurePassword
              //                 ? Icons.visibility
              //                 : Icons.visibility_off,
              //           ),
              //           onPressed: () {
              //             setState(() {
              //               _obscurePassword = !_obscurePassword;
              //             });
              //           },
              //         ),
              //       ],
              //     ),
              //     errorBorder: _isPasswordValid
              //         ? null
              //         : const OutlineInputBorder(
              //             borderSide: BorderSide(color: Colors.red),
              //           ),
              //   ),
              //   onChanged: (value) {
              //     setState(() {
              //       _isPasswordValid = _validatePassword(value) == null;
              //     });
              //   },
              //   validator: (value) {
              //     final error = _validatePassword(value);
              //     setState(() {
              //       _isPasswordValid = error == null;
              //     });
              //     return error;
              //   },
              //   onSaved: (value) {
              //     _password = value;
              //   },
              // ),
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
