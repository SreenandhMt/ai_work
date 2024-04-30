import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const height10 = SizedBox(height: 10,);
FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController _email = TextEditingController();
TextEditingController _pass = TextEditingController();

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.onTap,
  });
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.width*0.9,
                width: size.width*0.9,
                child: Lottie.asset("assets/5.json"),
              ),
              const Icon(Icons.lock,size: 50,color: Color.fromARGB(255, 207, 102, 3),),
              height10,
              TextFormField(controller: _email,decoration: InputDecoration(hintText: "Email",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
              height10,
              TextFormField(controller: _pass,decoration: InputDecoration(hintText: "Password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
              height10,
              height10,
              ElevatedButton(
                style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
                onPressed: (){
                try {
                  _auth.signInWithEmailAndPassword(email: _email.text, password: _pass.text);
                } catch (e) {
                  
                }
              }, child: Container(height: 70,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 182, 88, 0)),child: Center(child: const Text("LogIn")))),
               height10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text("You'r not Member"),
                  const SizedBox(width: 5,),
                  GestureDetector(onTap: onTap,child: const Text("Register")),
                ],)
            ],
          ),
        ),
      ),
    );
  }
}
