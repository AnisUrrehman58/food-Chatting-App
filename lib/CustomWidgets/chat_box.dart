import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/ChatScreen/chat_detail.dart';

import '../Service/Models/chat_user.dart';

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
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>  ChatDetail(user: widget.user)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 05),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                height: 60,
                width: 60,
                imageUrl: widget.user.image,
                placeholder: (context, url) => const Text(''),
                errorWidget: (context, url, error) => const CircleAvatar(child: Icon(Icons.person,))
              ),
            ),
            // const CircleAvatar(radius: 33,backgroundImage:
            // AssetImage('assets/user/user1.png')),
            Padding(
              padding: const EdgeInsets.only(top: 13,left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(widget.user.name,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5),
                  Text(widget.user.about,style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.5))),
                ],
              ),
            ),
            Expanded(

              child: Padding(
                padding:  const EdgeInsets.only(right: 10,bottom: 35),
                child: Text(widget.user.id,style: TextStyle(color: Colors.black.withOpacity(0.7)),textAlign: TextAlign.end),
              ),
            )
          ],
        ),

      ),
    );
  }
}
