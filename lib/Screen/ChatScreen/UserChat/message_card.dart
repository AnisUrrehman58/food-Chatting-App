import 'package:flutter/material.dart';
import 'package:food_chating_app/Service/Api/apis.dart';
import '../../../Service/Models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    super.key, required this.messages,
  });
  final Messages messages;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return  Apis.user.uid == widget.messages.fromId ? _greenMessage() :_blueMessage();
  }

  // send or another user message
  Widget _blueMessage(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration:  BoxDecoration(
                color: const Color.fromARGB(225,221, 245, 255),
                border: Border.all(color: Colors.blueAccent),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
            ),
            child: Text(widget.messages.msg)),
        ),
        
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Text(widget.messages.sent,style: const TextStyle(color: Colors.black54)),
        )
      ],
    );
  }

  Widget _greenMessage(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              const Icon(Icons.done_all_rounded,size: 18,color: Colors.blue),
              const SizedBox(width: 3),
              Text(widget.messages.sent,style: const TextStyle(color: Colors.black54,fontSize: 12)),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration:   BoxDecoration(
                color: Colors.grey[200],
                // border: Border.all(color: Colors.green),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),topRight: Radius.circular(30)),
            ),
            child: Text(widget.messages.msg,style: const TextStyle(fontSize: 15)),
          ),
        ),

      ],
    );
  }
}

// Stack(
// clipBehavior: Clip.none,
// children: [
// Text(widget.messages.msg,style: const TextStyle(fontSize: 15,),),
// Positioned(
// bottom: -15,
// right: -12,
// child: Row(
// children: [
// Text(widget.messages.toId,style: const TextStyle(color: Colors.black54,fontSize: 12)),
// const SizedBox(width: 5),
// const Icon(Icons.done_all_rounded,size: 18,color: Colors.blue),
// ],
// )),
// ],
// )





// Expanded(
//     child: ListView(
//         children: const [
//           ChatBubble(text: "Just to order",isSender: false),
//           ChatBubble(text: "Okay, for what level of spiciness?",isSender: true),
//           ChatBubble(text: "Okay, wait a minute 👍",isSender: false),
//           ChatBubble(text: "Okay I'm waiting 👍",isSender: true),
//         ]
//     ));
