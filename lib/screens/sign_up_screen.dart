import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Resoureces/auth_methodes.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/utils.dart';

import '../Responsive/mobile_screen_layout.dart';
import '../Responsive/responsive_layout.dart';
import '../Responsive/web_screen_layout.dart';
import '../Widgets/text_feild_input.dart';
import '../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen ({Key? key}) : super(key: key);

  @override
  State<SignUpScreen > createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen > {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  void selectImage() async{
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

   void signUpUser() async {

     setState(() {
       _isLoading = true;
     });

     String res =  await AuthMethods().signUpUser(
       email: _emailController.text,
       password: _passwordController.text,
       username: _userNameController.text,
       bio: _bioController.text,
       file: _image!,
     );

     setState(() {
       _isLoading = false;
     });

     if(res != 'success') {
       showSnackBar(res, context);
     } else {
       Navigator.of(context).pushReplacement(
           MaterialPageRoute(
             builder: (context) => const ResponsiveLayout(
               mobileScreenLayout: mobileScreenLayout(),
               webScreenLayout: webScreenLayout(),
             )
           )
       );
     }
   }

  void navigateToLogIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>const LoginScreen(),),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2,),
              // logo
              SvgPicture.asset(
                "assets/logo-insta.svg",
                color: primaryColor,
                height: 64,
              ),

              const SizedBox(height: 64,),

              //circuler widget to accsept and show our selected files
              Stack(
                children: [
                  _image!=null?CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  )
                 :const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/03/91/19/22/240_F_391192211_2w5pQpFV1aozYQhcIw3FqA35vuTxJKrB.jpg'),
                  ),
                  Positioned(
                    bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      )
                  )
                ],
              ),

              const SizedBox(height: 24,),

              // text field input for username
              TextFeildInput(
                textInputType: TextInputType.text,
                textEditingController: _userNameController,
                hintText: 'Enter your username',
              ),

              const SizedBox(height: 24,),

              // text field input for email
              TextFeildInput(
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                hintText: 'Enter your email',
              ),

              const SizedBox(height: 24,),

              //text feild input for password
              TextFeildInput(
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                isPass: true,
              ),

              const SizedBox(height: 24,),

              // text field input for bio
              TextFeildInput(
                textInputType: TextInputType.text,
                textEditingController: _bioController,
                hintText: 'Enter your bio',
              ),

              const SizedBox(height: 24,),

              // button for login
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4),
                          )
                      ),
                      color: blueColor
                  ),
                  child: _isLoading?const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ):const Text("Sign up"),
                ),
              ),

              const SizedBox(height: 12,),
              Flexible(child: Container(), flex: 2,),

              //Transition for signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account !"),
                  ),
                  GestureDetector(
                    onTap: navigateToLogIn,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(" Log in.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
