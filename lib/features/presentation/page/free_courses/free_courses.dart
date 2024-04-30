import 'package:flutter/material.dart';

class FreeCoursesRegistration extends StatelessWidget {
  const FreeCoursesRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(keyboardType: TextInputType.phone,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),gapPadding: 10),hintText: "Phone Number"),),
          TextFormField(keyboardType: TextInputType.name,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),gapPadding: 10),hintText: "Name"),),
          TextFormField(keyboardType: TextInputType.emailAddress,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),gapPadding: 10),hintText: "Email"),),
          ElevatedButton(onPressed: (){}, child: const Text("Submit"))
        ],
      ),
    );
  }
}