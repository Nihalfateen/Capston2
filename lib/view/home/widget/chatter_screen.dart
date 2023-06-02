import 'package:capstone/view_model/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/cache_helper.dart';
import '../../../model/data_source/remote/profile.dart';
import '../../../model/model/home_data.dart';

final patientName = CacheHelper.getPrefs(key: Constants.patientName);
final _firestore = FirebaseFirestore.instance;
String username = patientName;
String username2 = 'doctor';
String email = 'user@example.com';
String? messageText;
List<Doctort> doctor = [];
List<Patients> patient = [];
final userType = CacheHelper.getPrefs(key: Constants.userData);
String? user;

class ChatterScreen extends ConsumerStatefulWidget {
  static const String route = 'chatter_screen';
  String? name;
  ChatterScreen({super.key, this.name});
  @override
  _ChatterScreenState createState() => _ChatterScreenState();
}

class _ChatterScreenState extends ConsumerState<ChatterScreen> {
  final chatMsgTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    getCurrentUser();
    getMessages();
    Future.delayed(Duration.zero, () => ref.read(homeVM).getHomeData());
    super.initState();
  }

  void getCurrentUser() async {
    String type = Constants.doctor;
    final List<Doctort> doctor = await getHomeDataService();
    final userType = CacheHelper.getPrefs(key: Constants.userData);
    final userId = CacheHelper.getPrefs(key: Constants.id);
    if (userType != Constants.doctor) {
      type = Constants.patient;
    }
    doctor.map((doctor1) {
      if (doctor1.id == userId) {
        user = doctor1.name;
      }
    }).toList();
  }

  void getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data);
    }
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      snapshot.docs;
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(homeVM).patient;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepPurple),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(25, 10),
          child: Container(
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.blue[100],
            ),
            decoration: BoxDecoration(
                // color: Colors.blue,

                // borderRadius: BorderRadius.circular(20)
                ),
            constraints: BoxConstraints.expand(height: 1),
          ),
        ),
        backgroundColor: Colors.white10,
        // leading: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: CircleAvatar(backgroundImage: NetworkImage('https://cdn.clipart.email/93ce84c4f719bd9a234fb92ab331bec4_frisco-specialty-clinic-vail-health_480-480.png'),),
        // ),
        title: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Chat Screen',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: Colors.deepPurple),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChatStream(),
          Chat(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                      child: TextField(
                        onChanged: (value) {
                          messageText = value;
                        },
                        controller: chatMsgTextController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          hintText: 'Type your message here...',
                          hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                    shape: CircleBorder(),
                    color: Colors.blue,
                    onPressed: () {
                      chatMsgTextController.clear();
                      _firestore.collection('messages').add({
                        'sender': username,
                        'text': messageText,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                        'senderemail': email,
                        'receiver': username2
                      });
                      _firestore.collection('testm').get();
                      print('2222222$username');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                    // Text(
                    //   'Send',
                    //   style: kSendButtonTextStyle,
                    // ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatStream extends ConsumerStatefulWidget {
  @override
  ConsumerState<ChatStream> createState() => _ChatStreamState();
}

class _ChatStreamState extends ConsumerState<ChatStream> {
  final patientName = CacheHelper.getPrefs(key: Constants.patientName);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.docs;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final msgText = message.data()['text'];
            final msgSender = message.data()['sender'];
            final msgReceiver = message.data()['receiver'];
            // final msgSenderEmail = message.data['senderemail'];
            final currentUser = patientName;
            final user = 'doctor';
            print("=============$patientName");
            // print('MSG'+msgSender + '  CURR'+currentUser);
            final msgBubble = MessageBubble(
                msgText: msgText,
                msgSender: msgSender,
                msgReceiver: msgReceiver,
                user2: user == msgReceiver,
                user: currentUser == msgSender);
            print('===$msgSender');
            messageWidgets.add(msgBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: messageWidgets,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.deepPurple),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final String msgReceiver;
  final bool user;
  final bool user2;
  MessageBubble(
      {required this.msgText,
      required this.msgSender,
      required this.user,
      required this.msgReceiver,
      required this.user2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              msgSender,
              style: TextStyle(fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: user ? Radius.circular(50) : Radius.circular(0),
              bottomRight: Radius.circular(50),
              topRight: user ? Radius.circular(50) : Radius.circular(0),
            ),
            color: user ? Colors.blue : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msgText,
                style: TextStyle(
                  color: user ? Colors.white : Colors.blue,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Chat extends ConsumerStatefulWidget {
  @override
  ConsumerState<Chat> createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {
  final patientName = CacheHelper.getPrefs(key: Constants.patientName);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('testm').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.docs;
          List<Message> messageWidgets = [];
          for (var message in messages) {
            final msgText = message.data()['message'];
            final msgSender = message.data()['sender'];
            // final msgSenderEmail = message.data['senderemail'];
            final currentUser = 'doctor';
            // print('MSG'+msgSender + '  CURR'+currentUser);
            final msgBubble =
                Message(msgText: msgText, msgSender: msgSender, user: currentUser == msgSender);
            print('===$msgSender');
            messageWidgets.add(msgBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: messageWidgets,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.deepPurple),
          );
        }
      },
    );
  }
}

class Message extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;
  Message({
    required this.msgText,
    required this.msgSender,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              msgSender,
              style: TextStyle(fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: user ? Radius.circular(50) : Radius.circular(0),
              topRight: user ? Radius.circular(50) : Radius.circular(50),
              bottomRight: user ? Radius.circular(50) : Radius.circular(50),
            ),
            color: user ? Colors.white : Colors.blue,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msgText,
                style: TextStyle(
                  color: user ? Colors.blue : Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class ChatScreen extends StatefulWidget {
//   static const String route = 'chatter_screen';
//   const ChatScreen({super.key});
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final databaseReference = FirebaseDatabase.instance.reference().child('messages');
//   TextEditingController _messageController = TextEditingController();
//   List<String> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     databaseReference.onChildAdded.listen((DatabaseEvent event) {
//       setState(() {
//         messages.add(event.snapshot.value.toString());
//       });
//     });
//   }
//
//   void _sendMessage(String message) {
//     if (message.isNotEmpty) {
//       databaseReference.push().set(message);
//       _messageController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Screen'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(messages[index]),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     _sendMessage(_messageController.text);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
