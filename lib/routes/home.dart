import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vault_m/routes/change_pin.dart';
import 'package:vault_m/routes/customers.dart';
import 'package:vault_m/services/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _logout() async {
    try {
      await Provider.of<AuthProvider>(context, listen: false).logout();
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('failed: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 223, 245),
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: const Text('Vault Mobile'),
        ),
        leading: InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  color: const Color.fromARGB(255, 241, 223, 245),
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: const Color.fromARGB(255, 241, 234, 234),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePin(),
                                ),
                              ),
                              child: Text(
                                'Change pin',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: const Color.fromARGB(255, 241, 234, 234),
                        ),
                        height: 50,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.toggle_off_rounded),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: null,
                              child: Text(
                                'Enable/Disable bio metric',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        color: const Color.fromARGB(255, 245, 185, 185),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.delete, color: Colors.redAccent),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () async {
                                await Provider.of<AuthProvider>(
                                  context,
                                  listen: false,
                                ).logout();
                              },
                              child: Text(
                                'Sign out',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Icon(Icons.settings),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: const Color.fromARGB(255, 241, 223, 245),
              width: 250,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 190,
                      child: Row(
                        children: [
                          Icon(Icons.person_2_outlined),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => CustomersHomeScreen(),
                              )),
                            ),
                            child: Text(
                              'customers',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(child: Icon(Icons.arrow_right)),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              color: const Color.fromARGB(255, 241, 223, 245),
              width: 250,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 190,
                      child: Row(
                        children: [
                          Icon(Icons.directions_car_filled_outlined),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: null,
                            child: Text(
                              'Visitation log',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(child: Icon(Icons.arrow_right)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
