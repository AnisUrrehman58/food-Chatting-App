import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/ChatScreen/chat_screen.dart';

import '../../Service/Api/apis.dart';
import '../../Service/Models/chat_user.dart';
import '../../Service/Models/message.dart';
import 'UserChat/message_card.dart';


class ChatDetail extends StatefulWidget {
final ChatUser user;
  const ChatDetail({super.key, required this.user});

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {

    List<Messages>   _list = [];
final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_) =>  const ChatScreen()));
          }, icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: const Text('Chat', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))],

        ),
        body: Column(
          children: [
            // Chat Header
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
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
                  const SizedBox(width: 10),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(widget.user.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0)),
                      const Text('Online',style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(radius: 25,backgroundColor: Colors.pink.withOpacity(0.2),child:
                  const Icon(Icons.call,color: Colors.pinkAccent))
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: StreamBuilder(
                stream: Apis.getAllAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState){
                  /// if data is loading
                    case  ConnectionState.waiting:
                    case  ConnectionState.none:
                      return const Center(child: Text(''));

                  /// if some all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:

                      final data = snapshot.data?.docs;
                      _list = data?.map((e) => Messages.fromJson(e.data())).toList()?? [];


                      if(_list.isNotEmpty){
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: _list.length,
                            itemBuilder: (context, index) {
                              return  MessageCard(messages: _list[index]);
                            });
                      }else {
                        return const
                        Center(child: Text('Sey Hii! 👋',style: TextStyle(fontSize: 19)));
                      }

                  }

                },
              ),
            ),

            /// Send Message Input
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon:  Icon(Icons.emoji_emotions,color: Colors.pinkAccent.withOpacity(0.8))),
                    Expanded(
                      child: TextFormField(
                        controller: _textController,
                        // keyboardType: TextInputType.multiline,
                        maxLines: null,
                         decoration: const InputDecoration(
                          hintText: 'Type message...',
                          hintStyle: TextStyle(color: Colors.pinkAccent),
                          border: InputBorder.none,
                          // fillColor: Colors.grey[200],
                          // filled: true,
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){}, icon:  Icon(Icons.photo,color: Colors.pinkAccent.withOpacity(0.8).withOpacity(0.8))),
                    IconButton(onPressed: (){}, icon:  Icon(Icons.camera_alt,color: Colors.pinkAccent.withOpacity(0.8))),

                    const SizedBox(width: 8.0),
                     CircleAvatar(radius: 23.0,backgroundColor: Colors.pinkAccent,
                          child: IconButton(onPressed: (){
                            if(_textController.text.isNotEmpty){
                              Apis.sendMessage(widget.user, _textController.text);
                              _textController.clear();
                            }
                          }, icon: const Icon(Icons.send, color: Colors.white)) ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


