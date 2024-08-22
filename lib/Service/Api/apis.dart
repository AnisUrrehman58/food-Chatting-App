import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_chating_app/Service/Models/message.dart';

import '../Models/chat_user.dart';

class Apis {

  /// For Authentication
  static  FirebaseAuth auth = FirebaseAuth.instance;

  /// for Accessing calude FireStore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// for Accessing calude Firebase Storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  /// for Storing self info
  static late ChatUser me;

  /// return Current User
  static User get user => auth.currentUser!;

  /// For Checking user exists or  not?
  static Future<bool> userExists()async{
   return (await firestore.collection('User').doc(user.uid).get()).exists;
  }

  /// For getting Current info
  static Future<void> getSelfInfo()async{
    await firestore.collection('User').doc(user.uid).get().then((user ){
      if(user.exists){
        me = ChatUser.fromJson(user.data()!);
        log('My data: ${user.data()}');
      }else {
        createUser().then((value) => getSelfInfo());
      }
    });
  }

  /// For Creating New User
  static Future<void> createUser()async{
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey i'm using Food Chat Application",
      image: user.photoURL.toString(),
      createAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: 'User'
    );
    return await firestore.collection('User').doc(user.uid).set(chatUser.toJson());
  }



  /// For getting All user from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser(){
    return firestore.collection('User').where('id',isNotEqualTo: user.uid).snapshots();
  }


  /// For updating  User information data
  static Future<void> updateUserInfo()async{
     await firestore.collection('User').doc(user.uid).update({'name': me.name,'about': me.about});
  }


  /// Update Profile Picture
  static Future<void>updateProfilePicture (File file) async{
    /// Getting image file Extension
    final ext = file.path.split('.').last;
    log('Extension: $ext');

    /// Storage file ref with path
    final ref = storage.ref().child('profile_picture/${user.uid}.$ext');
    /// Uploading Image
   await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((pO) {
     log('Data transfer: ${pO.bytesTransferred / 1000} kb');
   });
   /// Updating Image in fire Store data base
   me.image = await ref.getDownloadURL();
    await firestore.collection('User').doc(user.uid).update({'image': me.image});
  }

     /// ************ Chat Screen Related Apis ************* ///
  // Use ful for getting conversation id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ?'${user.uid} _$id'
      :'${id}_${user.uid}';

// for getting all msg of a specific conversation from firestore data base
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllAllMessages(ChatUser user){
    return firestore.collection('Chats/${getConversationID(user.id)}/messeges/').snapshots();
  }

  /// For sending message
  static Future<void> sendMessage(ChatUser chatUser , String msg) async{
    // meg sending time (also use as id)
    final time  = DateTime.now().millisecondsSinceEpoch.toString();

    // msg to send
    final Messages messages = Messages(
        fromId: user.uid,
        msg: msg,
        toId: chatUser.id,
        type: Type.text,
        read: '',
        sent: time);
    final ref = firestore.collection('Chats/${getConversationID(chatUser.id)}/messeges/');

    await ref.doc(time).set(messages.toJson());

  }

}