import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "6917987a0ae941c2bcc8ec15c880761b";
const tokenk = "007eJxTYJDflFRvpJi+JSR8euj2pz8PfvRdr7hl5cuQWw79/Xef//mlwGBmaWhuaWGeaJCYamlimGyUlJxskZpsaJpsYWFgbmaYJJWvntYQyMjwLzOXgREKQXwWhpLU4hIGBgADIyHY";
String channel = "";


class SpeakWithOther extends StatefulWidget {
  const SpeakWithOther({super.key});

  @override
  State<SpeakWithOther> createState() => _SpeakWithOtherState();
}

class _SpeakWithOtherState extends State<SpeakWithOther> {
  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  String token="",docId="";
  int? _remoteUid;
  bool localUserJoined = false;
  RtcEngine? _engine;
  List<Map<String,dynamic>>? data;
  

  @override
  void initState() {
    super.initState();
    config();
  }

  void config() async {
    
    try {
       data = await _firebase
        .collection("tokens")
        .where("done", isEqualTo: 1)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    } catch (e) {
      return;
    }
    if (data == null ||data!.isEmpty || data!.first["token"] ==null||data!.first["token"].toString().isEmpty) {
      const expirationInSeconds = 3600;
  final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final expireTimestamp = currentTimestamp + expirationInSeconds;

      final tempToken = 
      RtcTokenBuilder.build(
        appId: appId,
        appCertificate: "5ca6444cf1e248b0940b68cb28257b71",
        channelName: FirebaseAuth.instance.currentUser!.uid,
        uid: "0",
        role: RtcRole.publisher,
        expireTimestamp: expireTimestamp,
      );

      final split =tempToken;
      final id = split.split("/");
      docId = id.first;
       await _firebase
        .collection("tokens").doc(id.first).set({
          "token":tempToken,
          "id":id.first,
          "date":Timestamp.now(),
          "done":1,
          "voicId":FirebaseAuth.instance.currentUser!.uid,
          "oName":FirebaseAuth.instance.currentUser!.email,
        });
        token = tempToken;
        channel = FirebaseAuth.instance.currentUser!.uid;
        initAgora();
        data = await _firebase
        .collection("tokens")
        .where("done", isEqualTo: 1)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
        return;
        
    }
    await _firebase
        .collection("tokens").doc(data!.first["id"]).update({
          "token":data!.first["token"],
          "id":data!.first["id"],
          "voicId":data!.first["voiceId"],
          "date":Timestamp.now(),
          "done":2,
          "oName":data!.first["oName"],
          "fName":FirebaseAuth.instance.currentUser!.email
        });
    channel = data!.first["voiceId"];
    token = data!.first["token"];

    initAgora();
    return;
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    // await _engine.enableVideo();
    await _engine!.startPreview();

    await _engine!.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    if(_engine!=null)
    {
      await _engine!.leaveChannel();
    await _engine!.release();
    }
    try {
      await _firebase.collection("tokens").doc(docId).delete();
    } catch (e) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(data!=null&&data!.isNotEmpty)
    {
      return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          UserWidget(height: (size.height / 2) * 0.76,name: data!.first["oName"],),
          _remoteUid!=null&&data!.first["fName"].isNotEmpty&&data!.first["fName"]!=null?UserWidget(height: (size.height / 2) * 0.76,name: data!.first["fName"],):SizedBox(),
        ],
      ),
    );
    }else{
      return Scaffold(
        backgroundColor: Colors.pink[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/7.json"),
          ],
        ),
      );
    }
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    Key? key,
    required this.height,
    required this.name,
  }) : super(key: key);
  final double height;
  final String name;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 10),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.primary),
      child: Center(child: Text(name),),
    );
  }
}
