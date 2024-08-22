import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/ProfileScreen/profile_screen.dart';
import 'package:food_chating_app/Service/Api/apis.dart';
import '../../CustomWidgets/chat_box.dart';
import '../../Service/Models/chat_user.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  // for Storing all User
   List<ChatUser> _list = [];

   // for storing all item
   final List<ChatUser> _searchList = [];

   bool _isSearching = false;
   @override
  void initState() {
    super.initState();
    Apis.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: (){
          if(_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          }else{
            return Future.value(false);

          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 1.5,
            leading: const Icon(Icons.home_outlined),
            centerTitle: true,
            title: _isSearching? TextFormField(
              style: const TextStyle(fontSize: 18,letterSpacing: 1.2),
        
              /// when search  text change then update search list
              onChanged: (value){
                /// Search Logic
               _searchList.clear();
               for(var i in _list) {
                 if(i.name.toLowerCase().contains(value.toLowerCase()) ||
                     i.email.toLowerCase().contains(value.toLowerCase())){
                   _searchList.add(i);
                 }
                 setState(() {
                   _searchList;
                 });
        
               }
              },
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Email Name....',
                hintStyle: TextStyle(fontSize: 16),
                border: InputBorder.none
              ),
            ) :const Text('Chat',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600)),
            actions: [
              IconButton(onPressed: (){
                setState(() {
                  _isSearching = ! _isSearching;
                });
              }, icon:  Icon(_isSearching ? CupertinoIcons.clear_circled_solid :Icons.search_outlined)),
              IconButton(
                onPressed: () {
                  if (_list.isNotEmpty) { // Check if the list is not empty
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfileScreen(user: Apis.me)));
                  } else {
                    // Optionally show a message or handle the empty state
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('List is empty, cannot open profile.')),
                    );
                  }
                },
                icon: const Icon(Icons.more_vert),
              ),

        
        
            ],
          ),
          body: StreamBuilder(
            stream: Apis.getAllUser(),
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
                 _list = data?.map((e) => ChatUser.fromJson(e.data())).toList()?? [];
        
                 if(_list.isNotEmpty){
                   return ListView.builder(
                         physics: const BouncingScrollPhysics(),
                         itemCount: _isSearching ? _searchList.length :_list.length,
                         itemBuilder: (context, index) {
                           return  Padding(
                             padding: const EdgeInsets.only(left: 15,right: 15),
                             child: Column(
                               children: [
                                 ChatBox(user: _isSearching ? _searchList[index] :_list[index])
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
              child:const Icon(Icons.add_comment,color: Colors.white)),
        ),
      ),
    );
  }
}

