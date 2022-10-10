import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      } }
    catch (e){
      print(e);
    }
  }

  void sendMessage() {
    messageTextController.clear();
    _firestore.collection('Messages for Doctor').add({
      'text': messageText,
      'sender': loggedInUser.email
    });
  }

  void messagesStream() async {
    await for(var snapshot in _firestore.collection('Messages for Doctor').snapshots()){
      for (var message in snapshot.docs){
        print(message.data());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
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
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                          color: Colors.black
                      ),
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed:
                    //Implement send functionality.
                    sendMessage,
                    child: Text(
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

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Messages for Doctor').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
          List<Widget> messageBubbles = [];
          messageBubbles.add(Container(height: 10));
          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];

            final currentUser = loggedInUser.email;

            final messageBubble = MessageBubble(
                sender: messageSender,
                text: messageText,
                isMe: currentUser == messageSender);
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
              reverse: true,
            ),
          );
        },
    );
  }
}


class MessageBubble extends StatelessWidget {

  MessageBubble({required this.sender, required this.text, required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    Color widgetBackground;
    BorderRadius widgetBorder;
    CrossAxisAlignment bubbleAlignment;

    if (isMe == true){
      //if the sender is same as current user
      widgetBackground = Colors.deepPurpleAccent;
      widgetBorder = BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
          topRight: Radius.circular(30.0)
      );
      bubbleAlignment = CrossAxisAlignment.start;
    } else {
      //if the message is from someone else
      widgetBackground = Colors.lightBlueAccent;
      widgetBorder = BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0)
      );
      bubbleAlignment = CrossAxisAlignment.end;
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: bubbleAlignment,
          children: [
            Text(
                sender,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12.0
                )
            ),
            Material(
              borderRadius: widgetBorder,
              elevation: 5.0,
              color: widgetBackground,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }
}