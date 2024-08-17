import 'package:flutter/material.dart';
import 'package:food_chating_app/constant/colors.dart';

import 'onboarding_screen2.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
                margin: const EdgeInsets.only(top: 70),
                height: height * 0.5,
                width: width * 0.99,
                decoration:  const BoxDecoration(
                  // color: Colors.pink,
                  image: DecorationImage(
                    image: AssetImage('assets/logos/logoBackGroundCircle.png'),fit: BoxFit.fill),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset('assets/logos/Donuts.png',fit: BoxFit.cover,height: 310),
                    Positioned(
                        bottom: 5,
                        left: 85,
                        child: Image.asset('assets/logos/Ellipse 3.png'))
                  ]
                )
              ),
              SizedBox(height: height * 0.10),
              const Text('Track your  Comfort',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
              const Text('Food here',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
              SizedBox(height: height * 0.01),
               Text('Here You Can find a chef or dish for every\n                  '
                  'taste and color. Enjoy!',style: TextStyle(fontSize: 15,color: AColors.textLight)
               ),
              SizedBox(height: height * 0.05),
              SizedBox(
                height: height * 0.07,
                  width: width * 0.45,
                  child: ElevatedButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen2()));
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
