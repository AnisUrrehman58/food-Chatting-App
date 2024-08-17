import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/loginScreen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constant/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Container(
        color: AColors.onBoardingBackGround,
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [

            /// OnBoardingScreen 1
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/logos/onboarding.png'),
                Positioned(
                    left: 2,
                    bottom: 30,
                    child: Image.asset('assets/logos/food1-removebg-preview 1.png')),
              ],
            ),
            Padding(
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
                  const Text('Track your  Comfort',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold)),
                  const Text('Food here',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.01),
                  Text('Here You Can find a chef or dish for every\n                  '
                      'taste and color. Enjoy!',style: TextStyle(fontSize: 15,color: AColors.textLight)
                  ),

                ],
              ),
            ),

            /// OnBoardingScreen 2
            Padding(
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
                  const Text('Foodie is Where Your',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold)),
                  const Text('Comfort Food Resides',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.01),
                  Text('Enjoy a fast and smooth food delivery at\n                       '
                      'your doorstep',style: TextStyle(fontSize: 15,color: AColors.textLight)
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

      bottomSheet: Container(
        height: 80,
        color: AColors.onBoardingBackGround,
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           GestureDetector(
             onTap: (){
               controller.jumpToPage(2);
             },
             child: CircleAvatar(
               radius: 26,
               backgroundColor: AColors.pink,
               child: const Text('Skip',style: TextStyle(color: Colors.white,fontSize: 13)),
             ),
           ),
            Center(
                child: SmoothPageIndicator(
                  count: 3,
                  effect: WormEffect(
                    spacing: 10,
                    dotHeight: 12,
                    dotWidth: 12,
                    activeDotColor: AColors.pink,
                    dotColor: CupertinoColors.systemGrey2
                  ),
                  controller: controller,
                )
            ),
            GestureDetector(
              onTap: (){
                if(isLastPage){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const LoginScreen()));
                }else{
                  controller.nextPage(duration: const Duration(microseconds: 500), curve: Curves.easeInOut);
                }
              },
              child: CircleAvatar(
                radius: 27,
                backgroundColor: AColors.pink,
                child: const Text('Next',style: TextStyle(color: Colors.white,fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
