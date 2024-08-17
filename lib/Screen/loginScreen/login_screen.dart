import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/ChatScreen/chat_screen.dart';
import 'package:food_chating_app/Screen/SignupScreen/signup_screen.dart';
import 'package:food_chating_app/Service/apis.dart';
import 'package:food_chating_app/constant/colors.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'CustomClipper/clipper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visible = false;

  handleGoogleBtnClick() {
    _signInWithGoogle().then((user) async {
      log('\nUser:${user.user}');
      log('\nUserAdditionalInfo:${user.additionalUserInfo}');
      if((await Apis.userExists())){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ChatScreen()));
      }else {
        Apis.createUser().then((value) => {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ChatScreen()))
        });
      }

    });
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AColors.onBoardingBackGround,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    padding:  EdgeInsets.only(top: height * 0.10),
                    height: height * 0.6,
                    width: width * 100,
                    decoration:  BoxDecoration(color: AColors.pink),
                    child: Column(
                      children: [

                        Image.asset('assets/logos/login-logo.png',
                          height: height * 0.15, // Adjust height as needed
                          width: width * 0.3,    // Adjust width as needed
                          fit: BoxFit.contain
                        ),
                        SizedBox(height: height * 0.01),
                        const Text('Deliver Favourite Food',
                          style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500,color: Colors.white)
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -230,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: height * 0.54,
                    width:  width * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.8),blurRadius: 3)],
                      border: Border.all(color: Colors.grey.withOpacity(0.5),width: 1.5)
                    ),
                    child:  Column(
                      children: [
                        const Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                        SizedBox(height: height * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  labelStyle: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  prefixIcon: const Icon(Icons.person,size: 30),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))
                                    ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  labelStyle: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  prefixIcon: const Icon(Icons.lock,size: 25),
                                  // suffixIcon: IconButton(onPressed: (){
                                  //   setState(() {
                                  //     visible = !visible;
                                  //   });
                                  // },icon: Icon(visible?Icons.visibility :Icons.visibility_off)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))
                                  ),
                                ),
                              ),
                              // SizedBox(height: height* 0.01),
                               TextButton(onPressed: (){}, child:  Text('Forget Password?',style: TextStyle(color: Colors.black.withOpacity(0.7)))),
                              SizedBox(height: height * 0.01),

                              SizedBox(
                                width: width * 0.99,
                                height: height *0.06,
                                child: ElevatedButton(onPressed: (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ChatScreen()));
                                },
                                  style: ElevatedButton.styleFrom(backgroundColor: AColors.pink,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    child: const Text('Login',style: TextStyle(color: Colors.white,fontSize: 20))),
                              ),
                              SizedBox(height: height * 0.02),
                               Center(child: Text('Or',style: TextStyle(color:AColors.pink,fontSize: 16))),


                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),



              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      handleGoogleBtnClick();
                    },
                    child: const CircleAvatar(radius: 25,backgroundImage: AssetImage('assets/Social-Login/google.jpg'))),
                const SizedBox(width: 10),
                const CircleAvatar(radius: 20,backgroundImage: AssetImage('assets/Social-Login/faceBook_logo - Copy.png')),
              ],
            ),
             Padding(
              padding: EdgeInsets.only(top: height * 0.30),
                child: const Text('Don’t have an account?',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignupScreen()));
            }, child:  Text('REGISTER',
                style: TextStyle(fontSize: 18,color: AColors.pink,fontWeight: FontWeight.w600))),
        
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}




