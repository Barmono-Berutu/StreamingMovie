import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messageText;

  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void sendMessage() {
    // Ambil teks dari controller
    messageText = messageTextController.text;

    // Kirim pesan ke Firestore
    _firestore.collection('messages').add({
      'text': messageText,
      'sender': loggedInUser.email,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Bersihkan TextField setelah mengirim pesan
    messageTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layanan'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessagesStream(loggedInUser: loggedInUser),
          ),
          Container(
            height: 80,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onSubmitted: (value) => sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.all(10),
                  ),
                  color: Theme.of(context).colorScheme.background,
                  iconSize: 30,
                  icon: Icon(Icons.send),
                  onPressed: () => sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final User loggedInUser; // Tambahkan variabel loggedInUser di sini

  MessagesStream({required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final messageText = message['text'];
          final messageSender = message['sender'];

          // Tentukan apakah pengirim pesan adalah pengguna yang sedang login
          final isMe = messageSender == loggedInUser.email;

          final isAdmin = messageSender == 'mono@gmail.com';
          final displaySender = isAdmin ? 'admin' : messageSender;

          final messageBubble = MessageBubble(
            sender: displaySender,
            text: messageText,
            isMe: isMe,
            isAdmin: isAdmin,
          );

          messageBubbles.add(messageBubble);
        }

        return ListView(
          reverse: true,
          children: messageBubbles,
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  final bool isAdmin;

  MessageBubble({
    required this.sender,
    required this.text,
    required this.isMe,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            Icon(isAdmin ? Icons.admin_panel_settings : Icons.person, size: 30),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Text(
                  isAdmin ? 'admin' : sender,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              SizedBox(
                height: 5,
              ),
              Material(
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                color: Colors.black,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
