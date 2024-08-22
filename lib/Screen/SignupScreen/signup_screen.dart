import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/loginScreen/login_screen.dart';

import '../../constant/colors.dart';
import '../loginScreen/CustomClipper/clipper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool visible = true;
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
              // alignment: Alignment.center,
              // clipBehavior: Clip.none,
              children: [
                Container(height: MediaQuery.of(context).size.height),
                Positioned(
                  child: ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      padding: EdgeInsets.only(top: height * 0.10),
                      height: height * 0.6,
                      width: width * 100,
                      decoration: BoxDecoration(color: AColors.pink),
                      child: Column(
                        children: [
                          Image.asset('assets/logos/login-logo.png',
                              height: height * 0.15, // Adjust height as needed
                              width: width * 0.3, // Adjust width as needed
                              fit: BoxFit.contain),
                          SizedBox(height: height * 0.01),
                          const Text('Deliver Favourite Food',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500, color: Colors.white)),])))),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 285),
                    padding: const EdgeInsets.only(top: 20),
                    height: height * 0.53,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.8),blurRadius: 3)
                        ],
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5), width: 1.5)),
                    child: Column(
                      children: [
                        const Text('Login',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(height: height * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  labelStyle: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  prefixIcon:
                                  const Icon(Icons.person, size: 30),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.1))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:Colors.grey.withOpacity(0.1))),
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  labelStyle: const TextStyle(color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  prefixIcon:
                                  const Icon(Icons.email, size: 30),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                          Colors.grey.withOpacity(0.1))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                          Colors.grey.withOpacity(0.1))),
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                              TextFormField(
                                obscureText: visible,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  prefixIcon:
                                  const Icon(Icons.lock, size: 25),
                                  suffixIcon: IconButton(onPressed: (){
                                    setState(() {
                                      visible = !visible;
                                    });
                                  },icon: Icon(visible?Icons.visibility_off:Icons.visibility)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                          Colors.grey.withOpacity(0.1))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                          Colors.grey.withOpacity(0.1))),
                                ),
                              ),
                              // SizedBox(height: height* 0.01),

                              SizedBox(height: height * 0.04),

                              SizedBox(
                                width: width * 0.99,
                                height: height * 0.06,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AColors.pink,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10))),
                                    child: const Text('Create A Account',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20))),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom:-16,
                  left: 100,
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: height * 0.30),
                          child: const Text(
                            'Already have an account?',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                          },
                          child: Text('SignIn',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AColors.pink,
                                  fontWeight: FontWeight.w600))),const SizedBox(height: 30)
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
