import 'package:ai_work/features/presentation/page/auth/auth_route/auth_route.dart';
import 'package:ai_work/features/presentation/page/boarding_screen/boarding_screen.dart';
import 'package:ai_work/features/presentation/page/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.hasData)
      {
        if(loginPage==false)
        {
          return const OnBoardingScreen();
        }
        return const ScreenHome();
      }else{
        return const AuthRoute();
      }
    },);
  }
}