import 'package:flutter/material.dart';

class PlainField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String> validator;
  final bool isInputValid;

  const PlainField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.isInputValid,
  });

  @override
  State<PlainField> createState() => _PlainFieldState();
}

class _PlainFieldState extends State<PlainField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color.fromARGB(255, 241, 223, 245),
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        errorBorder: widget.isInputValid
            ? null // Use default error border when valid
            : const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 4.0),
              ),
        suffixIcon: !widget.isInputValid
            ? const Icon(Icons.error, color: Colors.red)
            : null,
      ),
      validator: widget.validator,
    );
  }
}

class PlainField1 extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  const PlainField1({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  State<PlainField1> createState() => _PlainFieldState1();
}

class _PlainFieldState1 extends State<PlainField1> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color.fromARGB(255, 241, 223, 245),
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}

class PlainField2 extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool? isInputValid;

  const PlainField2({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.isInputValid,
  });

  @override
  State<PlainField2> createState() => _PlainFieldState2();
}

class _PlainFieldState2 extends State<PlainField2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color.fromARGB(255, 241, 223, 245),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        errorBorder: widget.isInputValid!
            ? null // Use default error border when valid
            : const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 4.0),
              ),
        suffixIcon: !widget.isInputValid!
            ? const Icon(Icons.error, color: Colors.red)
            : null,
      ),
      validator: widget.validator,
    );
  }
}
