import 'package:flutter/material.dart';
import 'package:vault_m/components/obsure_field.dart';
import 'package:vault_m/components/plain_field.dart';
import 'package:vault_m/routes/login.dart';
import 'package:vault_m/services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class AddCustomerPage extends StatelessWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Customer')),
      body: SingleChildScrollView(child: FormWidget()),
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
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 80),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 223, 245),
                ),

                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 50),
                      Icon(Icons.photo_camera),
                      Text(
                        'Take a picture',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
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
                                'Submit',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 73, 3, 85),
                                  fontWeight: FontWeight.bold,
                                ),
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




// final _emailController = TextEditingController();
// final _passwordController = TextEditingController();
// final _firstNameController = TextEditingController();
// final _lastNameController = TextEditingController();
// final _pinController = TextEditingController();
// final _email = TextEditingController();
// final _address = TextEditingController();
// final _firstName = TextEditingController();
// final _lastName = TextEditingController();
// final _otherName = TextEditingController();
// final _customerAddress = TextEditingController();
// final _customerBusinessAddress = TextEditingController();
// final _phoneNumber = TextEditingController();
// final _BVN = TextEditingController();
// final _NIN = TextEditingController();
// final _customerDOB = TextEditingController();
// final _utilityBillUrl = TextEditingController();
// final _identificationUrl = TextEditingController();


  // _firstNameController.dispose();
  //   _lastNameController.dispose();
  //   _pinController.dispose();
  //   _BVN.dispose();
  //   _NIN.dispose();
  //   _address.dispose();
  //   _customerAddress.dispose();
  //   _customerBusinessAddress.dispose();
  //   _customerDOB.dispose();
  //   _email.dispose();
  //   _firstName.dispose();
  //   _identificationUrl.dispose();
  //   _lastName.dispose();
  //   _otherName.dispose();
  //   _phoneNumber.dispose();
  //   _utilityBillUrl.dispose();