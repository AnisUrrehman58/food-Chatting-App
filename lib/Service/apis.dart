import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_chating_app/Service/Models/model.dart';

class Apis {

  /// For Authentication
  static  FirebaseAuth auth = FirebaseAuth.instance;

  /// for Accessing calude FireStore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// return Current User
  static User get user => auth.currentUser!;

  /// For Checking user exists or  not?
  static Future<bool> userExists()async{
   return (await firestore.collection('User').doc(user.uid).get()).exists;
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
      pushToken: ''
    );
    return await firestore.collection('User').doc(user.uid).set(chatUser.toJson());
  }

}