import 'package:boysbrigade/pages/home.dart';
import 'package:boysbrigade/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:boysbrigade/pages/error.dart';
import 'package:boysbrigade/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  String testProviderText = "Hello provider";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Error(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: MultiProvider(
                providers: [
                  Provider<String>(create: (context) => testProviderText),
                  StreamProvider<User>(
                      create: (context) =>
                          FirebaseAuth.instance.authStateChanges())
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Home(),
                ),
              ));
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Loading(),
        );
      },
    );
  }
}
