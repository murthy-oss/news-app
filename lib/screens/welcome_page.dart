import 'package:flutter/material.dart';
import 'package:newsapp1/const/colors.dart';

import 'package:newsapp1/screens/login.dart';
import 'package:newsapp1/screens/signup.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome_page.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.fromLTRB(30, screenHeight*0.022, 0, 0),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 0),
                buildRow(['Wel', 'come,', 'To'], [45, 40, 40]),
                buildRow(['News', ' App', ' V.'], [40, 40, 40]),
                const SizedBox(height: 120),
                buildButton('LogIn', const LogIN_Screen()),
                const SizedBox(height: 50),
                buildButton('SignUp', const Signup_Screen()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(List<String> texts, List<double> fontSizes) {
    return Row(
      children: List.generate(texts.length, (index) {
        return Text(
          texts[index],
          style: TextStyle(
            backgroundColor: index.isEven ? backgroundColors : custom_black,
            fontSize: fontSizes[index],
            fontWeight: FontWeight.bold,
            color: index.isEven ? custom_black : backgroundColors,
          ),
        );
      }),
    );
  }

  Widget buildButton(String content, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            content,
            style: const TextStyle(
              
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
