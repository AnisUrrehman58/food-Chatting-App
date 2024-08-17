import 'package:flutter/material.dart';
import 'package:food_chating_app/constant/colors.dart';

class ChatDetail extends StatelessWidget {
  const ChatDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios, size: 25)),
      ),
      resizeToAvoidBottomInset: true, // This line allows the screen to resize when the keyboard is opened
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Chat', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.05),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(radius: 35, backgroundImage: AssetImage('assets/user/user1.png')),
                              SizedBox(width: width * 0.04),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Naxient', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 5),
                                      Text('Online', style: TextStyle(color: Colors.black.withOpacity(0.5))),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CircleAvatar(
                                  radius: 23,
                                  backgroundColor: AColors.pink.withOpacity(0.2),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.phone, size: 28, color: AColors.pink),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey.withOpacity(0.6), thickness: 1.2),
                        // You can add chat bubbles here...
                        SizedBox(height: height * 0.45), // Adjust this height to control the space for chat messages
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
