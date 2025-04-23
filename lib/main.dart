import 'package:assessment3/FAQs.dart';
import 'package:assessment3/academic.dart';
import 'package:assessment3/dashboard.dart';
import 'package:assessment3/firstpage.dart';
import 'package:assessment3/loginpage.dart';
import 'package:assessment3/profilepage.dart';
import 'package:assessment3/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/first', // <- Start from profile page
      routes: {
        '/first': (context) => FirstPage(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/faq': (context) => HelpPage(),
        '/academic': (context) => ReferencesPage()
      },
    );
  }
}
