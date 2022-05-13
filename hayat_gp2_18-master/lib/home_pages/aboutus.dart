import 'package:flutter/material.dart';

class HomeAbout extends StatelessWidget {
  @override
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
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("images/Logo.jpg"))),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "\n What is Hayat ? ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[200],
                    fontSize: 30,
                  ),
                ),
                SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "\n Hayat is a Mobile-based application which can assist in collecting the left over food to distrbut it among those in need through Charity and Humanitarian organizations.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
