import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Resoureces/auth_methodes.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';

import '../Responsive/mobile_screen_layout.dart';
import '../Responsive/responsive_layout.dart';
import '../Responsive/web_screen_layout.dart';
import '../Widgets/text_feild_input.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }


  void loginUser() async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUaser(
        email: _emailController.text,
        password: _passwordController.text
    );
    if( res == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: mobileScreenLayout(),
                webScreenLayout: webScreenLayout(),
              )
          )
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigatToSignUp() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>const SignUpScreen(),));
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

              // text field input for email
              TextFeildInput(
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                hintText: 'Enter your email',
              ),

              SizedBox(height: 24,),

              //text feild input for password
              TextFeildInput(
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                isPass: true,
              ),

              const SizedBox(height: 24,),

              // button for login
              InkWell(
                onTap: loginUser,
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
                  child:_isLoading?const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ):const Text("Log in"),
                ),
              ),

              const SizedBox(height: 12,),
              Flexible(child: Container(), flex: 2,),

              //Transition for signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account ?"),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigatToSignUp,
                    child: Container(
                      child: Text(" Sign up.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
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
