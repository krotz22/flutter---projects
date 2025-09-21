import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/config.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey=GlobalKey<FormState>();
  TextEditingController _emailcon=TextEditingController();
  TextEditingController _passwordcon=TextEditingController();
  TextEditingController _namecon=TextEditingController();


  void registerUser()async{
    if (formkey.currentState!.validate()) {
      var regbody={
        "email" :_emailcon.text,
        "password":_passwordcon.text
      };
      var response =  await http.post(
        Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regbody),
      );
      
      // Proceed with registration since the form is valid
      // Add your registration logic here (e.g., sending data to backend)
    } else {
      // If the form is invalid, show an error
      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          
          key:formkey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
            
                    
              children: [
                SizedBox(
                      height: 120,
                    ),
                SizedBox(
                  
                  width: MediaQuery.of(context).size.width ,
                  child:Column(
                    children: [
                    
                      Text("Sign Up",
                      style:TextStyle(fontSize: 40, fontWeight: FontWeight.w700), ),
                      Text("Get started with your account"),
                      SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * .9,
                      child: TextFormField(
                        controller: _namecon,
                        validator: (value)=>
                          value!.isEmpty ? "Name cannot be empty":null,
                        decoration: InputDecoration(
                          
                            border: OutlineInputBorder(),
                            label: Text("Name"),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * .9,
                      child: TextFormField(
                        controller: _emailcon,
                        validator: (value)=>
                          value!.isEmpty ? "email cannot be empty":null,
                        decoration: InputDecoration(
                          
                            border: OutlineInputBorder(),
                            label: Text("Email"),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * .9,
                      child: TextFormField(
                        controller: _passwordcon,
                        validator: (value)=>
                          value!.length<8 ? "Password should have atleast 8 characters.":null,
                        obscureText: true,
                        decoration: InputDecoration(
                          
                            border: OutlineInputBorder(),
                            label: Text("Password"),),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  
                  SizedBox(
                    height: 60,
                    width:  MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(onPressed: (){
                      registerUser();
                     
                    }, child: Text("sign up",style: TextStyle(fontSize: 16),),),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Login"))
                    ],)
                    
                    ],
                  )
                )
                    
              ],
            ),
          )),
      ),
    );
  }
}