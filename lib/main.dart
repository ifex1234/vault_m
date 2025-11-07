// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:vault_m/routes/home.dart';
import 'package:vault_m/routes/login.dart';
import 'package:vault_m/routes/register.dart';
import 'package:provider/provider.dart';
import 'package:vault_m/routes/welcome_page.dart';
import 'package:vault_m/services/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        title: 'Vault mobile App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            // Show a loading indicator while checking auth status
            if (authProvider.token == null && !authProvider.isAuthenticated) {
              // This is a bit of a hack to ensure _loadTokenAndUser completes
              // before deciding the route. A better way would be a dedicated SplashScreen.
              // For simplicity, we'll wait for the first notifyListeners() after
              // _loadTokenAndUser has finished.
              Future.microtask(() async {
                await Future.delayed(
                  Duration.zero,
                ); // Allow builder to return before async
                if (!authProvider.isAuthenticated &&
                    authProvider.token == null) {
                  // Only navigate if still not authenticated after initial load
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                  Navigator.of(context).pushReplacementNamed('/register');
                }
              });
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return authProvider.isAuthenticated
                ? const WelcomePage()
                : const RegistrationPage();
          },
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegistrationPage(),
          '/welcome': (context) => const WelcomePage(),
          '/home': (context) => const HomePage(),
          // '/create-customer': (context) => const CreateCustomerPage(),
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:vault_m/routes/password_reset.dart';
// import 'package:vault_m/routes/welcome_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Vault mobile App',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const WelcomePage(),
//     );
//   }
// }
