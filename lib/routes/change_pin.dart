import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vault_m/components/obsure_field.dart';
import 'package:vault_m/services/auth_provider.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  final _formKey = GlobalKey<FormState>();
  final _oldPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmNewPinController = TextEditingController();
  bool _isOldPinValid = true;
  bool _isNewPinValid = true;
  bool _isConfirmPinValid = true;
  bool _isLoading = false;

  Future<void> _pinReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<AuthProvider>(
          context,
          listen: false,
        ).resetPin(_oldPinController.text, _newPinController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Pin updated successfully, you can now sign in with your new pin',
            ),
          ),
        );
        Navigator.of(context).pushReplacementNamed('/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('pin reset failed: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _validateOldPin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your old pin';
    }
    return null;
  }

  String? _validateNewPin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a 4 digit pin';
    }
    if (value.length != 4) {
      return 'Pin must not be less than or greater than 4 long';
    }
    return null;
  }

  String? _validateConfirmPin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your new pin';
    }
    if (value != _newPinController.text) {
      return 'Pins do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change pin'),
        backgroundColor: const Color.fromARGB(255, 252, 232, 252),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 60),
        child: SizedBox(
          height: 500,
          width: 320,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Change pin',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),

                ObscuredField(
                  controller: _oldPinController,
                  isInputValid: _isOldPinValid,
                  labelText: 'Old pin',
                  hintText: 'Old pin',
                  validator: (value) {
                    final error = _validateOldPin(value);
                    setState(() {
                      _isOldPinValid = error == null;
                    });
                    return error;
                  },
                ),
                SizedBox(height: 75),

                ObscuredField(
                  controller: _newPinController,
                  isInputValid: _isNewPinValid,
                  labelText: 'New pin',
                  hintText: 'New pin',
                  validator: (value) {
                    final error = _validateNewPin(value);
                    setState(() {
                      _isNewPinValid = error == null;
                    });
                    return error;
                  },
                ),
                SizedBox(height: 25),

                ObscuredField(
                  controller: _confirmNewPinController,
                  isInputValid: _isConfirmPinValid,
                  labelText: 'Confirm pin',
                  hintText: 'Confirm pin',
                  validator: (value) {
                    final error = _validateConfirmPin(value);
                    setState(() {
                      _isConfirmPinValid = error == null;
                    });
                    return error;
                  },
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 235, 221, 240),
                  ),
                  onPressed: _pinReset,
                  child: Text(
                    'Change',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
