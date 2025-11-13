import 'package:flutter/material.dart';
import 'package:vault_m/components/camera_picker.dart';
import 'package:vault_m/components/date_picker.dart';
import 'package:vault_m/components/dialog.dart';
import 'package:vault_m/components/dropdown.dart';
import 'package:vault_m/components/plain_field.dart';
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

void _showConfirmationDialog(BuildContext context) {
  showCameraDialog(
    context,
    title: 'Take Pictures',
    message:
        'Are you sure you want to proceed with this action? if yes, kindly follow the instructions below',
    backgroundColor: const Color.fromARGB(
      255,
      214,
      203,
      218,
    ), // Custom background for the card and icon
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(false); // Pop with a result
        },
        child: const Text('Cancel'),
      ),
      InkWell(
        child: Text('Ok', style: TextStyle(fontSize: 16)),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraScreen()),
        ),
      ),
    ],
  ).then((result) {
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result ? 'Camera loaded!' : 'Action Canceled.')),
      );
    }
  });
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _dob;
  String? _selectedUserGender;
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _street = TextEditingController();
  final _street2 = TextEditingController();
  final _bStop = TextEditingController();
  final _area = TextEditingController();
  final _state = TextEditingController();
  final _bizStreet = TextEditingController();
  final _bizStreet2 = TextEditingController();
  final _bizBStop = TextEditingController();
  final _bizArea = TextEditingController();
  final _bizState = TextEditingController();
  String? _customerAddress;
  String? _customerBusinessAddress;
  final _phoneNumber = TextEditingController();
  final _phoneNumber2 = TextEditingController();
  final _BVN = TextEditingController();
  final _NIN = TextEditingController();
  final _customerDOB = TextEditingController();
  final _utilityBillUrl = TextEditingController();
  final _identificationUrl = TextEditingController();
  bool _isLoading = false;

  String _verifyAddress() {
    return _customerAddress = "$_street $_street2  $_area  $_bStop  $_state";
  }

  String _verifyBizAddress() {
    return _customerBusinessAddress =
        "$_street $_street2  $_area  $_bStop  $_state";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _BVN.dispose();
    _NIN.dispose();
    _street.dispose();
    _street2.dispose();
    _bStop.dispose();
    _area.dispose();
    _state.dispose();
    _bizStreet.dispose();
    _bizStreet2.dispose();
    _bizBStop.dispose();
    _bizArea.dispose();
    _bizState.dispose();
    _customerAddress;
    _customerBusinessAddress;
    _customerDOB.dispose();
    _identificationUrl.dispose();
    _phoneNumber.dispose();
    _phoneNumber2.dispose();
    _utilityBillUrl.dispose();
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
                  borderRadius: BorderRadius.circular(
                    10,
                  ), // Optional: for rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        241,
                        223,
                        245,
                      ), // Color of the shadow
                      spreadRadius: 7,
                      offset: Offset(5, 5), // Offset of the shadow (x, y)
                    ),
                  ],
                ),

                child: Center(
                  child: InkWell(
                    onTap: () => _showConfirmationDialog(context),
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
              ),

              SizedBox(height: 15),

              PlainField1(
                controller: _NIN,
                labelText: 'NIN',
                hintText: 'Enter your NIN',
              ),
              SizedBox(height: 15),

              PlainField1(
                controller: _BVN,
                labelText: ' BVN',
                hintText: 'Enter your BVN',
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: PlainField1(
                      controller: _lastNameController,
                      labelText: 'Last name',
                      hintText: 'Enter your last name',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: PlainField1(
                      controller: _firstNameController,
                      labelText: 'First name',
                      hintText: 'Enter your first name',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DatePicker(
                        initialDate: _dob,
                        onDateSelected: (date) {
                          setState(() {
                            _dob = date;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(width: 10),
                  Expanded(
                    child: GenderSelector(
                      initialGender: _selectedUserGender,
                      onChanged: (gender) {
                        setState(() {
                          _selectedUserGender = gender;
                        });
                        print('Selected gender: $_selectedUserGender');
                      },
                      // You can customize options or hint text
                      genderOptions: const ['Male', 'Female'],
                      hintText: 'Gender',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              PlainField1(
                controller: _phoneNumber,
                labelText: 'Phone 1',
                hintText: 'Enter phone number',
              ),
              SizedBox(height: 10),
              PlainField1(
                controller: _phoneNumber2,
                labelText: 'Phone 2 (optional)',
                hintText: 'Enter phone number',
              ),
              SizedBox(height: 10),
              PlainField1(
                controller: _emailController,
                labelText: 'Email (optional)',
                hintText: 'Enter email',
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _identificationUrl,
                decoration: InputDecoration(
                  labelText: 'ID card',
                  hintText: 'ID card',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 241, 223, 245),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  suffixIcon: Icon(Icons.attach_file),
                ),
              ),
              TextFormField(
                controller: _utilityBillUrl,
                decoration: InputDecoration(
                  labelText: 'Utility bill',
                  hintText: 'Utility bill',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 241, 223, 245),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  suffixIcon: Icon(Icons.attach_file),
                ),
              ),

              SizedBox(height: 30),

              Text(
                'Home Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),
              PlainField1(
                controller: _street,
                labelText: 'Street',
                hintText: 'Street',
              ),
              SizedBox(height: 10),
              PlainField1(
                controller: _street2,
                labelText: 'Street2',
                hintText: 'Street2',
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: PlainField1(
                      controller: _area,
                      labelText: 'Area',
                      hintText: 'Area',
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: PlainField1(
                      controller: _bStop,
                      labelText: 'Bus stop',
                      hintText: 'Bus stop',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: PlainField1(
                      controller: _state,
                      labelText: 'State',
                      hintText: 'State',
                    ),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: () {
                      _verifyAddress();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                      elevation: 2,
                      backgroundColor: const Color.fromARGB(255, 245, 215, 250),
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        color: Color.fromARGB(255, 73, 3, 85),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),

              Text(
                'Business Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),
              PlainField1(
                controller: _bizStreet,
                labelText: 'Street',
                hintText: 'Street',
              ),
              SizedBox(height: 10),
              PlainField1(
                controller: _bizStreet2,
                labelText: 'Street2',
                hintText: 'Street2',
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: PlainField1(
                      controller: _bizArea,
                      labelText: 'Area',
                      hintText: 'Area',
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: PlainField1(
                      controller: _bizBStop,
                      labelText: 'Bus stop',
                      hintText: 'Bus stop',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: PlainField1(
                      controller: _bizState,
                      labelText: 'State',
                      hintText: 'State',
                    ),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: () {
                      _verifyBizAddress();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                      elevation: 2,
                      backgroundColor: const Color.fromARGB(255, 245, 215, 250),
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        color: Color.fromARGB(255, 73, 3, 85),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),

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
                                // _register();
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
