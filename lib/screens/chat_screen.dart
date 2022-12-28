import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static String id = "/chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  late User loggedin;

  late String messagetext;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        loggedin = user;
      }
    } catch (e) {
      print(e);
    }

    print(loggedin.email);
  }

  void getMessages() async {
    final messages = await _firestore.collection("messages").get();

    for (var messages in messages.docs) {
      print(messages.data());
    }
  }

  @override
  void initState() {
    getCurrentUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality

                _auth.signOut();

                Navigator.pop(context);
              }),
        ],
        title: Text('Not ChatGPT'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection("messages").snapshots(),
              builder: (context, snapshot) {
                final data = [];
                final username = [];
                if (snapshot.hasData) {
                  final messages = snapshot.data?.docs;

                  List<Text> messagesList = [];

                  for (var message in messages!) {
                    final text = message.data()["text"];

                    final sender = message.data()["sender"];

                    data.add(text);
                    username.add(sender);
                  }
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title: Text(data[index]),
                        subtitle: Text(username[index]),
                      );
                    }),
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Implement send functionality.

                      _firestore.collection("messages").add({
                        "text": messagetext,
                        "sender": loggedin.displayName ?? "none",
                      });

                      // getMessages();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
