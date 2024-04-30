
import 'package:ai_work/features/presentation/page/ai_speak/speak_with_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../speak_with_other/speak_with_other.dart';

//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
final _controller = PageController();

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("New English Classes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              const Text("Usefull Videos",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              LimitedBox(
                maxWidth: double.infinity,
                maxHeight: 250,
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) => setState(() {}),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    5,
                    (index) => Container(
                      width: size.width * 0.95,
                      height: 200,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ),
              SmoothPageIndicator(controller: _controller, count: 5,axisDirection: Axis.horizontal),
              const SizedBox(height: 20),
              const Text("Free Featurs",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SpeakWithAi(),
                    )),
                    child: Container(
                        width: (size.width / 2) * 0.9,
                        height: 200,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary),
                        child: Stack(
                            children: [
                              Lottie.asset('assets/2.json',frameBuilder:(context, child, composition) {
                            if(composition==null)
                            {
                              return const CupertinoActivityIndicator();
                            }else{
                              return child;
                            }
                          }, 
                          ),
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Speak With Ai"),
                            ),
                          ),
                            ],
                          ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SpeakWithOther(),
                    )),
                    child: Container(
                      width: (size.width / 2) * 0.9,
                      height: 200,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary),
                      child:  Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Lottie.asset('assets/3.json',repeat: false,frameBuilder:(context, child, composition) {
                              if(composition==null)
                              {
                                return const CupertinoActivityIndicator();
                              }else{
                                return child;
                              }
                            }, ),
                          ),
                          const Align(alignment: Alignment.bottomCenter,child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Speak With Other"),
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Text("Registration",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              Row(
                children: [
                  Container(
                    width: (size.width / 2) * 0.9,
                    height: 200,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary),
                    child:  Stack(
                      children: [
                        Lottie.asset('assets/4.json',frameBuilder:(context, child, composition) {
                            if(composition==null)
                            {
                              return const CupertinoActivityIndicator();
                            }else{
                              return child;
                            }
                          }, ),
                          const Align(alignment: Alignment.bottomCenter,child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Free"),
                          )),
                      ],
                    ),
                  ),
                  Container(
                    width: (size.width / 2) * 0.9,
                    height: 200,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary),
                    child: Stack(
                      children: [
                        Lottie.asset('assets/9.json',repeat: false,frameBuilder:(context, child, composition) {
                            if(composition==null)
                            {
                              return const CupertinoActivityIndicator();
                            }else{
                              return child;
                            }
                          }, ),
                          const Align(alignment: Alignment.bottomCenter,child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Paid"),
                          )),
                      ],
                    ),
                  )
                ],
              ),
              
            ],
          )
        ],
      ),
    );
  }
}