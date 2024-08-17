import 'package:flutter/material.dart';
import 'package:food_chating_app/Service/Models/model.dart';
import 'package:food_chating_app/Service/apis.dart';
import '../../CustomWidgets/chat_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        leading: const Icon(Icons.home_outlined),
        centerTitle: true,
        title: const Text('Chat',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600)),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search_outlined)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: StreamBuilder(
        stream: Apis.firestore.collection('Users').snapshots(),

        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            /// if data is loading
            case  ConnectionState.waiting:
            case  ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

              /// if some data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:

              final data = snapshot.data?.docs;
             list = data?.map((e) => ChatUser.fromJson(e.data())).toList()?? [];

             if(list.isNotEmpty){
               return
                 ListView.builder(
                     physics: const BouncingScrollPhysics(),
                     itemCount: list.length,
                     itemBuilder: (context, index) {
                       return  Padding(
                         padding: const EdgeInsets.only(left: 15,right: 15),
                         child: Column(
                           children: [

                             ChatBox(user: list[index]),
                           ],
                         ),
                       );
                     });
             }else {
               return const Center(child: Text('No Connection Found!.',style: TextStyle(fontSize: 20)));
             }

          }

        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},backgroundColor:Colors.blue,
          child:const Icon(Icons.add_comment,color: Colors.white,)),
    );
  }
}

