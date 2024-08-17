import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/ChatScreen/practice_chat.dart';

import '../Service/Models/model.dart';

class ChatBox extends StatefulWidget {
  final ChatUser user;

  const ChatBox({
    super.key, required this.user,

  });

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PracticeChat()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 15),
        height: height *0.1,
        width: width * 0.99,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.2),width: 1.5),
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Chat Box
            const CircleAvatar(radius: 33,backgroundImage:
            AssetImage('assets/user/user1.png')),
            SizedBox(width: width * 0.03),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(widget.user.about,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                    const SizedBox(height: 5),
                    Text(widget.user.name,style: TextStyle(color: Colors.black.withOpacity(0.5))),
                  ],
                ),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.only(right: 10,bottom: 35),
              child: Text(widget.user.id,style: TextStyle(color: Colors.black.withOpacity(0.7))),
            )
          ],
        ),

      ),
    );
  }
}
