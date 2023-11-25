// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, camel_case_types, unnecessary_string_interpolations, prefer_final_fields, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:newsapp1/const/colors.dart';
import 'package:newsapp1/screens/login.dart';


class Signup_Screen extends StatefulWidget {
  
   const Signup_Screen({super.key});

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
   FocusNode _focusNode3 = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final passwordconfirmcontroller = TextEditingController();
 
   late String _email, _password;
  String? _emailError;
  bool isLoading=false;
  String? _passwordError;

  void _validateInputs() {
    setState(() {
      if (_emailController.text.isEmpty ||
          !RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
              .hasMatch(_emailController.text)) {
        _emailError = 'Enter a valid email address';
      } else {
        _emailError = null;
      }

      if (_passwordController.text.isEmpty ||
          _passwordController.text.length < 6) {
        _passwordError = 'Password must be at least 6 characters long';
      } else {
        _passwordError = null;
      }
      if(_passwordController.text!=passwordconfirmcontroller.text){
          _passwordError = 'Both Passwords are not same';
      }
      if (_emailError == null && _passwordError == null) {
        // Both email and password are valid, you can perform further actions here
        // For example, you can authenticate the user
       // if (_formkey.currentState!.validate()) {
         
          setState(() {
            isLoading=true;
          });
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password)
              .then((user) {
                  setState(() {
             isLoading=false;
          });
           Fluttertoast.showToast(msg: "Register success");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LogIN_Screen()),
                ( route) => false);
          }).catchError((onError) {
            setState(() {
            isLoading=false;
          });
          Fluttertoast.showToast(msg: "Error$onError".toString());
          });
       // }
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body:(isLoading)?
       const Center(child: CircularProgressIndicator())
       : SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            image(),
            const SizedBox(
              height: 50,
            ),
            
            Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _emailController,
        focusNode: _focusNode1,
       
        
         onChanged: (item) {
                          setState(() {
                            _email = item;
                          });
                        },
        style: const TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: _focusNode1.hasFocus ? custom_green : const Color(0xffc5c5c5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              
          hintText: 'Enter Email',
          labelText: 'Email',
          errorText: _emailError,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              )),
        ),
      ),
    ),
  ),
            const SizedBox(
              height: 10,
            ),
            Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _passwordController,
        focusNode: _focusNode2,
       
         obscureText: true,
                        onChanged: (item) {
                          setState(() {
                            _password = item;
                          });
                        },
        style: const TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.password,
            color: _focusNode2.hasFocus ? custom_green : const Color(0xffc5c5c5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: 'Enter Password',
          labelText: 'Passsword',
          errorText: _passwordError,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              )),
        ),
      ),
    ),
  ),
            const SizedBox(
              height: 10,
            ),
            Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: passwordconfirmcontroller,
        focusNode: _focusNode3,
        
        obscureText: true,
                        onChanged: (item) {
                          setState(() {
                          });
                        },
        style: const TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.password,
            color: _focusNode3.hasFocus ? custom_green : const Color(0xffc5c5c5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: 'Enter ConfirmPassword',
          labelText: 'Confirm Password',
          errorText: _passwordError,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              )),
        ),
      ),
    ),
  ),
            const SizedBox(
              height: 8,
            ),
            Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Already have an account??",
          style: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: (){
             Navigator.push(context, 
                  MaterialPageRoute(
            builder:
                  (context) => const LogIN_Screen(),));
                  
          },
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
            const SizedBox(
              height: 20,
            ),
            
Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: GestureDetector(
      onTap: (){
       
        _validateInputs();
        },
    
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: custom_green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),

          ],
        ),
      )),
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/logsin.jpg'),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

Widget textfield(TextEditingController _controller, FocusNode _focusNode,
    String typename, IconData Iconss) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: const TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Iconss,
            color: _focusNode.hasFocus ? custom_green : const Color(0xffc5c5c5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: '$typename',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              )),
        ),
      ),
    ),
  );
}
