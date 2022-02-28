import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/offers/search_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/main.dart';

class offerDetailes extends StatelessWidget {
  var SelectedOfferCategory;
  var SelectedOfferStatus;
  var SelectedAvailableQuantity;
  var SelectedExpirationDate;
  var SelectedPic;
  var SelectedDonorId;

  offerDetailes(
      {Key? key,
      this.SelectedOfferCategory,
      this.SelectedOfferStatus,
      this.SelectedAvailableQuantity,
      this.SelectedExpirationDate,
      this.SelectedPic,
      this.SelectedDonorId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var C = this.SelectedOfferCategory;
    var S = this.SelectedOfferStatus;
    var A = this.SelectedAvailableQuantity;
    var E = this.SelectedExpirationDate;
    var P = this.SelectedPic;
    var I = this.SelectedDonorId;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey[200],
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginAll()));
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //                 <--- border radius here
                ),
            color: Colors.white70,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Text(
                'Donation offer details',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text('\n\n\nFood Category of the Donation: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\n' + C,
                overflow: TextOverflow.visible,
              ),
              Text('\nFood Status of Donation: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\n' + S,
                overflow: TextOverflow.visible,
              ),
              Text('\nAvailable Quantity (# person): ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\n' + A,
                overflow: TextOverflow.visible,
              ),
              Text('\nExpiration date: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\n' + E + '\n',
                overflow: TextOverflow.visible,
              ),
              Divider(color: Colors.grey),
              Text(
                '\nDonor information',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              // Text(' '),
            ],
          ),
        ));
  }
}
