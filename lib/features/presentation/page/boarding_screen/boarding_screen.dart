import 'package:ai_work/features/presentation/page/auth/auth_gate.dart';
import 'package:ai_work/features/presentation/page/auth/auth_route/auth_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

PageController _controller = PageController();
bool onDone=false;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    // _controller.jumpTo(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                onDone = (value==3);
              });
            },
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              Intro1(),
              Intro2(),
              Intro3(),
              Intro4(),
            ],
          ),
          Align(
            alignment: const Alignment(0,0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(onTap: ()=>_controller.jumpTo(3),child: const Text("skip")),
                SmoothPageIndicator(
                  axisDirection: Axis.horizontal,
                      controller: _controller,
                      count: 4,
                      effect: const WormEffect(
                        dotHeight: 16,
                        dotWidth: 16,
                        type: WormType.thinUnderground,
                      ),
                    ),
                    onDone==true?
                    GestureDetector(onTap: (){onDone=false;Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {loginPage=true; return const AuthGate();}), (route) => false);},child: const Text("done")):GestureDetector(onTap: ()=>_controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn),child: const Text("next")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Ai Grammar Fixing and Reviewing",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
          ),
          Lottie.asset("assets/2.json"),
        ],
      ),
    );
  }
}

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Speak with Other Students",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
          ),
          Lottie.asset("assets/7.json"),
        ],
      ),
    );
  }
}

class Intro3 extends StatelessWidget {
  const Intro3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 114, 73, 164),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Monthly Free Courses",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
          ),
          Lottie.asset("assets/8.json"),
        ],
      ),
    );
  }
}

class Intro4 extends StatelessWidget {
  const Intro4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 181, 86, 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("6 Month Paid Course Registraion",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
          ),
          Lottie.asset("assets/9.json",repeat: false),
        ],
      ),
    );
  }
}