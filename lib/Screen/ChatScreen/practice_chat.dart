import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/ChatScreen/chat_screen.dart';

class PracticeChat extends StatelessWidget {
  const PracticeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChatScreen()));
        }, icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text('Chat', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

      ),
      body: Column(
        children: [
          // Chat Header
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/user/user1.png'),
                  radius: 30.0,
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Naxient',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Online',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
               CircleAvatar(
                 radius: 25,
                 backgroundColor: Colors.pink.withOpacity(0.2),
                 child:  const Icon(
                   Icons.call,
                   color: Colors.pinkAccent,
                 ),
               )
              ],
            ),
          ),
          Divider(),

          // Chat Messages
          Expanded(
            child: ListView(
              children: [
                ChatBubble(
                  text: "Just to order",
                  isSender: false,
                ),
                ChatBubble(
                  text: "Okay, for what level of spiciness?",
                  isSender: true,
                ),
                ChatBubble(
                  text: "Okay, wait a minute 👍",
                  isSender: false,
                ),
                ChatBubble(
                  text: "Okay I'm waiting 👍",
                  isSender: true,
                ),
              ],
            ),
          ),

          // Send Message Input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Send message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.pinkAccent,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  ChatBubble ({required this.text, required this.isSender});
  final String text;
   final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: isSender ? Colors.pinkAccent.withOpacity(0.2) : Colors.grey[200],
          borderRadius: isSender
              ? const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          )
              : const BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16.0)),
      ),
    );
  }
}
