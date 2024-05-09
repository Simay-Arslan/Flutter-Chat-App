import 'package:chat_app/auth/auth_page.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/screens/home_page.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/profile_page.dart';
import 'package:chat_app/screens/users_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers : [
        ChangeNotifierProvider(create: (_) => UserProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light
        ),
        routes: {
          '/home_page':(context)=>HomePage(),
          '/profile_page':(context)=>ProfilePage(),
          '/users_page':(context)=>UsersPage(),
          '/login_screen':(context)=>LoginScreen(),
        },
        home: Scaffold(

          body: FirebaseAuth.instance.currentUser == null ? LoginScreen(): HomePage(),
          )),
        );

  }
}

