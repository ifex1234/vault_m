import 'package:flutter/material.dart';
import 'package:vault_m/routes/add_customer.dart';
import 'package:vault_m/routes/change_pin.dart';
import 'package:vault_m/routes/customers.dart';
import 'package:vault_m/routes/home.dart';
import 'package:vault_m/routes/login.dart';
import 'package:vault_m/routes/password_reset.dart';
import 'package:vault_m/routes/register.dart';
import 'package:vault_m/routes/welcome_page.dart';

class Displaypages extends StatelessWidget {
  const Displaypages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOCK PAGE'),
        backgroundColor: const Color.fromARGB(255, 252, 232, 252),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              child: Text('Registeration page', style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistrationPage()),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text('Login page', style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text('Add customer', style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCustomerPage()),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text('Change pin', style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePin()),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text('Customers home', style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomersHomeScreen()),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text('Home', style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text('Password reset', style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResetPasswordPage()),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text('Welcome page', style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
