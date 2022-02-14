import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class HomeContact extends StatelessWidget {
  @override
  //google/tw/insta/numb
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.home_outlined),
          ),
          backgroundColor: Colors.teal[200],
          title: Text(
            "Hayat food donation",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.teal[50],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ContactUs(
              cardColor: Colors.white,
              textColor: Colors.teal.shade500,
              logo: AssetImage('images/Logo.jpg'),
              email: 'gp18.sfd@gmail.com',
              companyName: 'Hayat',
              companyColor: Colors.teal.shade100,
              dividerThickness: 2,
              phoneNumber: '+966050',
              tagLine: 'Hayat team',
              taglineColor: Colors.grey.shade700,
              twitterHandle: '',
              instagram: '',
              facebookHandle: ''),
        ),
      ),
    );
  }
}
