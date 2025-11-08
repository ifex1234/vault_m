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
        _mycustomersFuture = ApiService().fetchCustomers(authProvider.token!);
      });
    } else {
      // Handle case where not authenticated, perhaps navigate to login
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
            onPressed: () async {
              await authProvider.logout();
            },
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
                // child: Text('You have not created any customers yet.'),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
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

                          // color: const Color.fromARGB(255, 244, 233, 247),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                // color: const Color.fromARGB(255, 241, 223, 245),
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
                                    // color: const Color.fromARGB(255, 241, 223, 245),
                                    width: 200,
                                    child: Text(
                                      'helllllllllooooo',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                // color: const Color.fromARGB(255, 241, 223, 245),
                                width: 50,
                                child: Text('40%'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.lastName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (post.address != null &&
                              post.customerAddress!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                post.customerBusinessAddress!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          const SizedBox(height: 8),

                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Created: ${post.createdAt.toLocal().toString().split(' ')[0]}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed('/create-post');
          if (result == true) {
            _refreshList(); // Refresh posts if a new post was created
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
