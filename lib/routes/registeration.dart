import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Registration Page')),
      body: Padding(
        padding: const EdgeInsets.only(left: 45, top: 120),
        child: SizedBox(
          height: 500,
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vault Mobile',
                style: TextStyle(fontSize: 52, fontWeight: FontWeight.w500),
              ),

              Text(
                'Sign In',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
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
  String? _email;
  String? _password;
  bool _isPasswordValid = true;
  bool _obscurePassword = true;

  void _submit() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Processing Data')));
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: SizedBox(
          height: 320,
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  final error = _validateEmail(value);
                  setState(() {
                    _isEmailValid = error == null;
                  });
                  return error;
                },

                onSaved: (val) {
                  _email = val;
                },
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
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty == false) {
                    return null;
                  } else if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return 'Not a valid password.';
                },
                onSaved: (val) {
                  _email = val;
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
                padding: const EdgeInsets.only(top: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),

                    Text('I forgot my password'),
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
