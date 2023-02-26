import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/sign_in_page.dart';
import '../home/main_screen.dart';

class AuthOrMainPageDirector extends StatelessWidget {
  AuthOrMainPageDirector({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.hasData ? MainScreen() : SignInPage();
        });
  }
}
