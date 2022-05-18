import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/contract/cho_list.dart';
import 'package:hayat_gp2_18/contract/contract_form.dart';
import 'package:hayat_gp2_18/contract/view_contract_donor.dart';
import 'package:hayat_gp2_18/home_pages/donor_home_2.dart';
import 'package:hayat_gp2_18/home_pages/donor_home_3.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';

class HomeD extends StatelessWidget {
  var Did;

  HomeD(this.Did) : super();

  @override
  Widget build(BuildContext context) {
    var Donorid1 = Did;
    print(Donorid1);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Hayat food donation',
        ),
        backgroundColor: Colors.teal[200],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: Text("Logout"),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginAll()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: GridView.count(
          crossAxisCount: 1,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Card(
                elevation: 20,
                color: Colors.white,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    print('heyy' + Donorid1);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeD2(Did)));
                  },
                  splashColor: Colors.red,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('images/ContractTap.png',
                            height: 160, fit: BoxFit.fill),
                        Text("Contracts",
                            style: new TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Card(
                elevation: 20,
                color: Colors.white,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeD3(Did)));
                  },
                  splashColor: Colors.red,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Column(
                      children: <Widget>[
                        Text("\n"),
                        Image.asset('images/MydonationsTap.png',
                            fit: BoxFit.fill),
                        Text("Donations",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
