import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_chating_app/Screen/loginScreen/login_screen.dart';
import 'package:food_chating_app/Service/Api/apis.dart';
import 'package:image_picker/image_picker.dart';

import '../../Service/Models/chat_user.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? _image;
final _formKey = GlobalKey<FormState>();
  void signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }
    void _bottomShowSheet(){
    showModalBottomSheet(context: context, builder: (_) =>
        Container(
          height: 190,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
          child:  ListView(
            children:    [
              const SizedBox(height: 20),
              const Text('Pick Profile Picture',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),textAlign: TextAlign.center),
              const SizedBox(height: 10),

              /// Image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();

                          // Pick an image.
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);

                          if(image != null){
                            log('Image Path: ${image.path} -- Mimetype: ${image.mimeType}');
                            setState(() {
                              _image = image.path;
                            });
                            Apis.updateProfilePicture(File(_image!));
                            /// For hiding Bottom Sheet
                            Navigator.pop(context);
                          }

                        },
                        child: const Image(image: AssetImage('assets/Image/gallery.png'),height: 100)),
                    GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();

                          // Pick an image.
                          final XFile? image = await picker.pickImage(source: ImageSource.camera,imageQuality: 80);

                          if(image != null){
                            log('Image Path: ${image.path}');
                            setState(() {
                              _image = image.path;
                            });
                            /// For hiding Bottom Sheet
                            Apis.updateProfilePicture(File(_image!));
                            Navigator.pop(context);
                          }
                        },
                        child: const Image(image: AssetImage('assets/Image/Camera.png'),height: 120,))
                  ],
                ),
              )

            ],
          ),
        )
    );
   }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile Screen'),
          elevation: 5,
        ),

        body:   Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                /// Profile Picture Selected
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Stack(
                      children: [
                        _image  != null ?     ClipRRect(
                    borderRadius: BorderRadius.circular(height * 0.12),
                    child: Image.file(
                      File(_image!),
                        height: height * 0.20,
                        width: width * 0.42,
                        fit: BoxFit.fill,
                    ),
                  ):
                        ClipRRect(
                          borderRadius: BorderRadius.circular(height * 0.12),
                          child: CachedNetworkImage(
                              height: height * 0.20,
                              width: width * 0.40,
                              fit: BoxFit.cover,
                              imageUrl: widget.user.image,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const CircleAvatar(child: Icon(Icons.person,))
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: MaterialButton(onPressed: (){
                              _bottomShowSheet();
                            },color: Colors.blue,
                                shape: const CircleBorder(),height:45,child: const Icon(Icons.edit,color: Colors.white)))
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Text(widget.user.email,style: const TextStyle(fontSize: 18,color: Colors.black54)),
                  SizedBox(height: height * 0.05),

                  /// name form
                  TextFormField(
                    onSaved: (value) => Apis.me.name = value ?? '',
                    validator: (value) => value != null && value.isNotEmpty ? null : 'Required Filed',
                    initialValue: widget.user.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline,color: Colors.grey),
                      labelText: 'Name',
                      labelStyle: const TextStyle(color: Colors.grey,fontSize: 20),
                      border: OutlineInputBorder(
                        borderSide:  const BorderSide(color: Colors.grey,width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey,width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  /// About form
                  SizedBox(height: height * 0.05),
                  TextFormField(
                    onSaved: (value) => Apis.me.about = value?? '',
                    validator: (value) => value != null && value.isNotEmpty ? null : 'Required Filed',
                    initialValue: widget.user.about,
                    decoration: InputDecoration(
                      labelText: 'About',
                      prefixIcon: const Icon(Icons.info_outline,color: Colors.grey),
                      labelStyle: const TextStyle(color: Colors.grey,fontSize: 20),
                     border : OutlineInputBorder(
                        borderSide:  const BorderSide(color: Colors.grey,width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey,width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.05),

                  ElevatedButton.icon(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      Apis.updateUserInfo().then((value) => {
                        ScaffoldMessenger.of(context).showSnackBar(
                          
                           SnackBar(content: const Text('Update successfully',style: TextStyle(fontSize: 17),),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.green,)
                        )

                      });
                    }
                  },
                      style: ElevatedButton.styleFrom(minimumSize: Size(width * 0.35, height * 0.06),backgroundColor: Colors.blue),
                      icon: const Icon(Icons.edit,color: Colors.white),
                      label: const Text('Update',style: TextStyle(color: Colors.white,fontSize: 17),))


                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar:   Container(
          margin: const EdgeInsets.only(left: 270,bottom: 20,right: 10),
          child: FloatingActionButton.extended(onPressed: (() => signOut(context)),
              icon:const Icon(Icons.exit_to_app,color: Colors.white,size: 30),
              label: const Text('Logout',style: TextStyle(color: Colors.white,fontSize: 18)),
              backgroundColor: Colors.redAccent,
              ),
        ),
      ),
    );
  }
}
