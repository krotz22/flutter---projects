import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/config.dart';
import 'dart:convert';

import 'package:todoapp/views/dashboard.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey=GlobalKey<FormState>();
  TextEditingController _emailcon=TextEditingController();
  TextEditingController _passwordcon=TextEditingController();
  late SharedPreferences prefs;
   bool isPrefsInitialized = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }
   Future<void>  initSharedPref()async{
    prefs= await SharedPreferences.getInstance();
    setState(() {
      isPrefsInitialized = true; // Mark as initialized
    });
  }
   void loginUser()async{
    if (!isPrefsInitialized) {
      print('SharedPreferences not initialized yet');
      return;
    }
    if (formkey.currentState!.validate()) {
      var regbody={
        "email" :_emailcon.text,
        "password":_passwordcon.text
      };
      var response = await http.post(
        Uri.parse(login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regbody),
      );
      var responsejson= jsonDecode(response.body);
      if (responsejson['status']){
        var myToken=responsejson['token'];
        prefs.setString('token', myToken);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(token: myToken)));
      }
      else{

      }
     
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
                    
                      Text("Login",
                      style:TextStyle(fontSize: 40, fontWeight: FontWeight.w700), ),
                      Text("Get started with your account"),
                      SizedBox(
                      height: 10,
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        showDialog(context: context, builder: (Builder){
                            return AlertDialog(
                              title: Text("Forgot Password"),
                              content:Column(
                                 mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter your email"),
                                   SizedBox(height: 10,),
                                  TextFormField (controller:  _emailcon, decoration: InputDecoration(label: Text("Email"), border: OutlineInputBorder()),),

                                ],
                              ) ,
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Cancel")),
                                TextButton(onPressed: ()async{
                                  
                                
                                }, child: Text("Submit")),
                                
                              ],
                            );

                        });

                      }, child: Text("Forgot Password"))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width:  MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(onPressed: (){
                    
                    loginUser();






                    }, child: Text("Login",style: TextStyle(fontSize: 16),)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have and account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/signup");
                        },
                        child: Text("Sign Up"))

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