import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'EDUMATE',
        ),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set your desired color
          fontSize: 20, // Set your desired font size
          fontWeight: FontWeight.bold, // Optional
        ),
      ),
      body: Column(children: [
        ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://th.bing.com/th?id=OIP.DxpcKmgZZtv0kMLJpaTJLgHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2'),
          ),
          title: Text('keera'),
          subtitle: Text('sit22cs071'),
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(Icons.calendar_month),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Year: 3',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(Icons.star),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'CGPA: 9.5',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'N0 :18 rice mill road \n old pallavarm ,chennai-44',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.blue,
                        ),
                        Text(
                          "Fee details",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.book,
                          color: Colors.blue,
                        ),
                        Text(
                          "Attendance ",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.blue,
                        ),
                        Text(
                          "Call details",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
