// import 'package:flutter/material.dart';

// class ResetPasswordPage extends StatefulWidget {
//   const ResetPasswordPage({super.key});

//   @override
//   State<ResetPasswordPage> createState() => _ResetPasswordState();
// }

// class _ResetPasswordState extends State<ResetPasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   String? _email;
//   bool _isEmailValid = true;

//   void _onPress() {
//     final form = _formKey.currentState;
//     if (form != null && form.validate()) {
//       form.save();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'A password reset link has been sent to your email $_email',
//           ),
//         ),
//       );
//     }
//   }

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter an email';
//     }
//     // Basic email validation regex
//     final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
//     if (!emailRegex.hasMatch(value)) {
//       return 'Invalid email address';
//     }
//     return null; // Return null if the email is valid
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // leading: ,
//         title: const Text('Sign In'),
//         backgroundColor: const Color.fromARGB(255, 252, 232, 252),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 45, top: 120),
//         child: SizedBox(
//           height: 500,
//           width: 320,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 40),
//               Text(
//                 'Reset Password',
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 12),

//               TextFormField(
//                 validator: (value) {
//                   final error = validateEmail(value);
//                   setState(() {
//                     _isEmailValid = error == null;
//                   });
//                   return error;
//                 },

//                 onSaved: (val) {
//                   _email = val;
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter your email',
//                   labelText: 'Email',
//                   filled: true,
//                   border: UnderlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   errorBorder: _isEmailValid
//                       ? null // Use default error border when valid
//                       : const UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red, width: 4.0),
//                         ),
//                   fillColor: const Color.fromARGB(255, 243, 229, 252),
//                   suffixIcon: !_isEmailValid
//                       ? const Icon(Icons.error, color: Colors.red)
//                       : null,
//                 ),
//               ),
//               SizedBox(height: 25),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 235, 221, 240),
//                 ),
//                 onPressed: _onPress,
//                 child: Text(
//                   'Reset Password',
//                   style: TextStyle(color: Colors.deepPurple),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
