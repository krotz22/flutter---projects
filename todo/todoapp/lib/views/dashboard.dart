import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/config.dart';
import 'package:todoapp/views/login.dart';
class Dashboard extends StatefulWidget {
  final token;
  const Dashboard({required this.token,super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String userid;
  TextEditingController _todoTitle = TextEditingController();
  TextEditingController _todoDesc = TextEditingController();
  //final List<String> items = new List<String>.generate(10, (i)=>"item ${i+1}");
  List? items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken= JwtDecoder.decode(widget.token);
    userid=jwtDecodedToken['_id'];
    print(userid);
    getToDo(userid);
  }
 Future<void> logout(BuildContext context) async {
    // Clear the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove token

    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
  //adding toodo
   void addToDo()async{
    if (_todoTitle.text.isNotEmpty && _todoDesc.text.isNotEmpty) {
      var regbody={
        "userId":userid,
        "title" :_todoTitle.text,
        "desc":_todoDesc.text
      };
      var response = await  http.post(
        Uri.parse(storeTodo),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regbody),
      );
      var responsejson =jsonDecode(response.body);
      if(responsejson['status']){
        _todoDesc.clear();
        _todoTitle.clear();
        Navigator.pop(context);
        getToDo(userid);
      } 
      else{
        print('something went wrong');

      }
     if (responsejson['status']){
      getToDo(userid);
    }
    } 
  }
  //getting todo from db
void getToDo(String userid) async {
  try {
    // Create the request body
    var regbody = {
      "userId": userid,
    };

    // Make the API call
    var response = await http.post(
      Uri.parse(TodoList),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regbody),
    );

    // Log the response for debugging
    print("API Response: ${response.body}");

    // Check if the response is successful
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);

      // Ensure that 'success' is in the response and is a List
      if (responseJson.containsKey('success') && responseJson['success'] is List) {
        items = List.from(responseJson['success']); // Update the items list
      } else {
        print("No 'success' key or it is not a list.");
        items = []; // Set items to an empty list in case of missing or invalid 'success'
      }
    } 
  } catch (e) {
    print("Error in getToDo: $e");
    items = []; // Set items to an empty list in case of an error
  }

  // Update the UI
  setState(() {});
}

  //delete an item
  void deleteItem(id)async {
     
    // Create the request body
    var regbody = {
      "id": id,
    };

    // Make the API call
    var response = await http.post(
      Uri.parse(deleteTodo),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regbody),
    );
    var responseJson = jsonDecode(response.body);
    print(responseJson);
    if (responseJson['status']){
      getToDo(userid);
    }
setState(() {});
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      backgroundColor: const Color.fromARGB(255, 241, 205, 137),
      appBar: AppBar(
        title: Text("Todo",style: TextStyle(fontFamily:'Times New Roman'),),
        backgroundColor:Color(0xFFFF6F61),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context), // Logout when pressed
          ),
          
        ],
      
        
      ),
      body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
  
            height: 230,
            width:  MediaQuery.of(context).size.width  ,
            decoration: BoxDecoration(
  image: DecorationImage(
    image: NetworkImage('https://i.pinimg.com/736x/38/71/48/387148c77ea124be919ae05d8b50fd30.jpg'),
    fit: BoxFit.cover,
  ),
),
            
          ),
          Expanded(
            child: Container(
            
            decoration: BoxDecoration(
              color:  const Color.fromARGB(255, 227, 228, 230),
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
          ),
          
            child: items == null ?null : ListView.builder(
              itemCount: items!.length,
              itemBuilder: (context,index){
                return  Slidable(
                           key: ValueKey(items ?[index]['_id']),
                           endActionPane: ActionPane(
                             motion: const ScrollMotion(),
                             dismissible: DismissiblePane(onDismissed: () { // Properly handle the removal of the item
        setState(() {
          items?.removeAt(index); // Remove the item from the list
        });}),
                             children: [
                               SlidableAction(
                                 backgroundColor: Color(0xFFFE4A49),
                                 foregroundColor: Colors.white,
                                 icon: Icons.delete,
                                 label: 'Delete',
                                 onPressed: (BuildContext context) {
                                   print('${items![index]}');
                                   deleteItem('${items![index]['_id']}');
                                 },
                               ),
                             ],
                           ),
                           child: Card(
                             borderOnForeground: false,
                             child: ListTile(
                               leading: Icon(Icons.task),
                             title: Text('${items![index]['title']}'),
                             subtitle: Text('${items![index]['desc']}'),
                             trailing: Icon(Icons.arrow_back),
                             ),
                           ),
                         );
          
            
            },),
          )
            ),

          
          
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed:()=> addTodoBox(context),
      child: Icon(Icons.add),
      tooltip: 'Addtodo',
      ),
    );
  }
  
  addTodoBox(BuildContext context) async {
    return showDialog(context: context, builder:(context){
      return AlertDialog(
        
        title: Text('Add To-Do'),
        content: Column(
           mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _todoTitle,
              decoration: InputDecoration(
                icon: Icon(Icons.send),
        hintText: 'Title',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
              ),

            ),
            SizedBox(height: 10,),
            TextField(
              controller: _todoDesc,
              decoration: InputDecoration(
                icon: Icon(Icons.send),
        hintText: 'Description',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
              ),

            ),
  SizedBox(height: 5,),
            ElevatedButton(onPressed: (){
addToDo();
            }, child: Text("Add") ),
          ],
        ),
      );

    });
  }
}

void deleteItem(String s) {
}

