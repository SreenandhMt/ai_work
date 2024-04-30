import 'package:ai_work/features/presentation/page/auth/login/login_page.dart';
import 'package:ai_work/features/presentation/page/auth/signin/signin_page.dart';
import 'package:flutter/material.dart';

bool loginPage =true;

class AuthRoute extends StatefulWidget {
  const AuthRoute({super.key});

  @override
  State<AuthRoute> createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  
  @override
  Widget build(BuildContext context) {
    if(loginPage)
    {
      return LoginForm(onTap: change,);
    }else{
      return SignInForm(onTap: change,);
    }
  }

  void change(){
    setState(() {
      loginPage = !loginPage;
    });
  }
}