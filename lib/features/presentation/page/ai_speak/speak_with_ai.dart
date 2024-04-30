import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

import '../../../../main.dart';

final List<Map<String, String>> messages = [];
FlutterTts tts = FlutterTts();
FlutterTts question = FlutterTts();

ValueNotifier<String> _massage = ValueNotifier("");
ValueNotifier<String> _userInput = ValueNotifier("");
ValueNotifier<String> _massageq = ValueNotifier("");
bool enabled = false;
final gemini = Gemini.instance;

class SpeakWithAi extends StatefulWidget {
  const SpeakWithAi({super.key});

  @override
  State<SpeakWithAi> createState() => _SpeakWithAiState();
}

class _SpeakWithAiState extends State<SpeakWithAi> {
  bool repeat = false,play=false;
  @override
  Widget build(BuildContext context) {
    if(_massageq.value.isEmpty)
    {
      askQuestion("Give me a Question for improve my english spiking skill only a one and simple qustion ");
    }
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          !repeat?
          Center(
            child: Lottie.asset("assets/10.json",repeat: false),
          ):Center(
            child: Lottie.asset("assets/10.json",repeat: true),
          ),
          const SizedBox(height: 10,),
          ValueListenableBuilder(valueListenable: _massageq, builder: (context, value, child) => Text(_massageq.value),),
          const SizedBox(height: 20,),
          ValueListenableBuilder(valueListenable: _userInput, builder: (context, value, child) => Text(_userInput.value),),
          const SizedBox(height: 20,),
          ValueListenableBuilder(valueListenable: _massage, builder: (context, value, child) => Text(_massage.value),),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // useAi(_controller.text);
          if (!enabled) {
            speechToText.listen(
              pauseFor: const Duration(seconds: 5),
              onResult: (onResult) {
              log(onResult.recognizedWords);
              log(onResult.recognizedWords);
              
              _userInput.value="${_userInput.value} ${onResult.recognizedWords}";
            }).whenComplete(() {
              enabled = false;
              useAi("Fix Grammar '${_userInput.value}' and give a review and give the improved answer");
            });
            enabled = true;
          } else {
            speechToText.stop();
            enabled = false;
          }
        },
        child: const Icon(Icons.mic),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void askQuestion(input) async {
    String data = "";
    _massage.value="";
    gemini.streamGenerateContent(input).listen((value) {
      data = "$data ${value.output!}";
    }).onDone(() {
      setState(() {
        repeat = true;
      });
      _massageq.value =data;
      question.speak(data);
    });
  }

  void useAi(String input) async {
    String data = "";
    gemini.streamGenerateContent(input).listen((value) {
      final remove = value.output!.split('**');

      for (var row in remove) {
        data = "$data $row";
      }
      
      final removestar = data.split('*');
      data="";
      for (var row in removestar) {
        data = "$data $row";
      }
      log(data.toString());
    }).onDone(() {
      _massage.value=data;
      setState(() {
     repeat = true;
    });
      tts.speak(data);
    });
    
    await tts.awaitSpeakCompletion(true);
    tts.setCompletionHandler(() async{
      
      _massageq.value ="Whait Next Question";
    _massage.value=".....";
    setState(() {
      repeat = false;
    });
    await Future.delayed(const Duration(seconds: 4));
    _massageq.value ="";
    _massage.value="";
     askQuestion("Give me a Question for improve my english spiking skill only a one and simple qustion ");
     tts.setCompletionHandler(() {setState(() {
        repeat = false;
      }); tts.setCompletionHandler(() {});});
    });
   
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }
}
