import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/loginScreen/login_screen.dart';

import '../../constant/colors.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: AColors.onBoardingBackGround,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            children: [
              Container(
                /// OnBoarding Logos
                  margin: const EdgeInsets.only(top: 110),
                  height: height * 0.40,
                  width: width * 0.99,
                  decoration:  const BoxDecoration(
                    // color: Colors.pink,
                    image: DecorationImage(
                        image: AssetImage('assets/logos/Ellipse 4.png'),fit: BoxFit.cover),
                  ),
                  child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset('assets/logos/FastFood.png',fit: BoxFit.cover,height: 230),

                        Positioned(
                           left: 280,
                            bottom: 5,
                            child: Image.asset('assets/logos/Ellipse 5.png'))

                      ]
                  )
              ),
              SizedBox(height: height * 0.15),
              const Text('Foodie is Where Your',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
              const Text('Comfort Food Resides',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
              SizedBox(height: height * 0.01),
              Text('Enjoy a fast and smooth food delivery at\n                       '
                  'your doorstep',style: TextStyle(fontSize: 15,color: AColors.textLight)
              ),
              SizedBox(height: height * 0.05),
              SizedBox(
                  height: height * 0.07,
                  width: width * 0.45,
                  child: ElevatedButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                      style: ElevatedButton.styleFrom(backgroundColor: AColors.pink,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: const Text('Next',style: TextStyle(color: Colors.white,fontSize: 20)))),

              SizedBox(height: height * 0.05)

            ],
          ),
        ),
      ),
    );
  }
  }

