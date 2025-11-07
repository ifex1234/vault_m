import 'package:flutter/material.dart';

class ObscuredField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String> validator;
  final bool isInputValid;

  const ObscuredField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.isInputValid,
  });

  @override
  State<ObscuredField> createState() => _ObscuredFieldState();
}

class _ObscuredFieldState extends State<ObscuredField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.numberWithOptions(),
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        errorBorder: widget.isInputValid
            ? null // Use default error border when valid
            : const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 4.0),
              ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}

class ObscuredField2 extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String> validator;
  final bool isInputValid;

  const ObscuredField2({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.isInputValid,
  });

  @override
  State<ObscuredField2> createState() => _ObscuredFieldState2();
}

class _ObscuredFieldState2 extends State<ObscuredField2> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        errorBorder: widget.isInputValid
            ? null // Use default error border when valid
            : const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 4.0),
              ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}
