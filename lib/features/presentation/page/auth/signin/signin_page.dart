import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const height10 = SizedBox(height: 10,);
FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController _email = TextEditingController();
TextEditingController _pass = TextEditingController();
TextEditingController _conformPass = TextEditingController();

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
    required this.onTap,
  }) : super(key: key);
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
              SizedBox(
                height: size.width*0.9,
                width: size.width*0.9,
                child: Lottie.asset("assets/6.json",repeat: false),
              ),
              // const Icon(Icons.lock,size: 30,),
              height10,
              TextFormField(controller: _email,decoration: InputDecoration(hintText: "Email",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
              height10,
              TextFormField(controller: _pass,decoration: InputDecoration(hintText: "Password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
              height10,
              TextFormField(controller: _conformPass,decoration: InputDecoration(hintText: "Conform Password",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
              height10,
              height10,
              ElevatedButton(
                style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
                onPressed: (){
               try {
                  _auth.createUserWithEmailAndPassword(email: _email.text, password: _pass.text);
               } catch (e) {
                 return;
               }
              }, child: Container(height: 70,width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff03dac6)),child: const Center(child: Text("SignIn")))),

              height10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text("Already a member"),
                const SizedBox(width: 5,),
                GestureDetector(onTap: onTap,child: const Text("Login")),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
