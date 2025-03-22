import 'package:brain_curve/Extension/theme.dart';
import 'package:brain_curve/Utils/customize_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatelessWidget {
  BrainCurveCustomizeStyle style=BrainCurveCustomizeStyle();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.backgroundColor,
        statusBarIconBrightness:
        context.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Images (Circular)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/user1.jpg'),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/user2.jpg'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Get started",
                style: style.headerStyle(color: context.textColor)
              ),
              SizedBox(height: 10),
              Text(
                "Register for events and create images of the\nactivities you plan to attend.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),
              signUpButton(
                text: "Sign up with Google",

                icon: Icons.email,
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(height: 15),
              signUpButton(
                text: "Sign up with email",
                icon: Icons.email,
                color: Colors.grey[850]!,
                textColor: Colors.white,
              ),
              SizedBox(height: 15),
              signUpButton(
                text: "Sign up with phone number",
                icon: Icons.phone,
                color: Colors.grey[850]!,
                textColor: Colors.white,
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Already have an account? Log in",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget signUpButton({
     required String text,
  IconData? icon,
  String? imagePath,
  required Color color,
  required Color textColor}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null) Image.asset(imagePath!, height: 24),
            if (icon != null) Icon(icon, color: textColor),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );

  }


}


