import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/offers/search_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/main.dart';

class contractDetailesForDonor extends StatelessWidget {
  var SelectedcontCategory;
  var SelectedcontStatus;
  var SelectedAvailableQuantity_c;
  var SelectedExpirationDate_c;
  var Selectedperiod;

  contractDetailesForDonor({
    Key? key,
    this.SelectedcontCategory,
    this.SelectedcontStatus,
    this.SelectedAvailableQuantity_c,
    this.SelectedExpirationDate_c,
    this.Selectedperiod,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var C = this.SelectedcontCategory;
    var S = this.SelectedcontStatus;
    var A = this.SelectedAvailableQuantity_c;
    var E = this.SelectedExpirationDate_c;
    var P = this.Selectedperiod;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey[200],
        appBar: AppBar(
          title: Text(
            'Hayat food donation',
          ),
          backgroundColor: Colors.teal[200],
          elevation: 0.0,
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
                'Contract details',
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
              Text('\n : period',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\n' + P + '\n',
                overflow: TextOverflow.visible,
              ),
              Divider(color: Colors.grey),

              // Text(' '),
            ],
          ),
        ));
  }
}
