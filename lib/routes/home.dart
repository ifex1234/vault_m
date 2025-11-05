import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                        color: const Color.fromARGB(255, 241, 234, 234),
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: null,
                              child: Text(
                                'Change pin',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        color: const Color.fromARGB(255, 241, 234, 234),
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
                              onTap: null,
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
              width: 240,
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        Icon(Icons.person_2_outlined),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: null,
                          child: Text(
                            'customers',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(children: [Icon(Icons.arrow_right), SizedBox(width: 10)]),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: const Color.fromARGB(255, 241, 223, 245),
              width: 240,
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 90,
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
                  Row(children: [Icon(Icons.arrow_right), SizedBox(width: 10)]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
