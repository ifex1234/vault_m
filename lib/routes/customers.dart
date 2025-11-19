import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vault_m/components/avatar.dart';
import 'package:vault_m/models/customers.dart';
import 'package:vault_m/routes/add_customer.dart';
import 'package:vault_m/services/api_service.dart';
import 'package:vault_m/services/auth_provider.dart';

class CustomersHomeScreen extends StatefulWidget {
  const CustomersHomeScreen({super.key});

  @override
  State<CustomersHomeScreen> createState() => _CustomersHomeScreenState();
}

class _CustomersHomeScreenState extends State<CustomersHomeScreen> {
  late Future<List<Customers>> _mycustomersFuture;

  @override
  void initState() {
    super.initState();
    _loadMyCustomers();
  }

  Future<void> _loadMyCustomers() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isAuthenticated && authProvider.token != null) {
      setState(() {
        _mycustomersFuture = ApiService().fetchCustomers(
          authProvider.token!,
          1,
        );
      });
    } else {
      _mycustomersFuture = Future.value([]); // Return an empty list
    }
  }

  Future<void> _refreshList() async {
    await _loadMyCustomers();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Customers'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refreshList),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              (MaterialPageRoute(builder: (context) => AddCustomerPage())),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await authProvider.logout();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: FutureBuilder<List<Customers>>(
          future: _mycustomersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('You have not created any customers yet.'),
              );
            } else {
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    debugPrint(data.email);
                    return Center(
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          (MaterialPageRoute(
                            builder: (context) => AddCustomerPage(),
                          )),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 244, 233, 247),
                            borderRadius: BorderRadius.horizontal(),
                          ),
                          height: 50,
                          width: 305,
                          margin: EdgeInsets.only(bottom: 10, top: 10),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: AvatarWidget(initials: 'VM', radius: 20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '25-jul-2025',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      data.firstName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(width: 50, child: Text('40%')),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
