import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/ChatScreen/chat_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PracticeOnBoarding extends StatefulWidget {
  const PracticeOnBoarding({super.key});

  @override
  State<PracticeOnBoarding> createState() => _PracticeOnBoardingState();
}

class _PracticeOnBoardingState extends State<PracticeOnBoarding> {
  final controller = PageController();
  bool isLastPage = false;
@override
  void dispose() {
  controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            Container(color: Colors.red,child: const Center(child: Text('Page 1',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white)))),
            Container(color: Colors.pink,child:  const Center(child: Text('Page 2',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white)))),
            Container(color: Colors.blueAccent,child:  const Center(child: Text('Page 3',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white))))
          ],
        ),
      ),
      bottomSheet:  Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () => controller.jumpToPage(2), child: const Text('Skip')),
            Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const WormEffect(
                    spacing: 12,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.green,
                  ),
                )),
            TextButton(
                onPressed: () {
                  if (isLastPage) {
                    // Navigate to home screen
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const ChatScreen()));
                  } else {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
                  }
                },
                child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}
