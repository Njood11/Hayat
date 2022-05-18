import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/contract/contract_details_charity.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/donations/donation_details_d.dart';
import 'package:hayat_gp2_18/donations/offer_details.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'contract_details.dart';

class PublishedContractC extends StatefulWidget {
  PublishedContractC({Key? key, this.Cid}) : super(key: key);
  var Cid;

  @override
  _PublishedcontractCState createState() => _PublishedcontractCState(this.Cid);
}

class _PublishedcontractCState extends State<PublishedContractC> {
  List<ParseObject> allcontracts = <ParseObject>[];
  var Cid;
  String status = '';
  _PublishedcontractCState(this.Cid);

// function to retrive all contracts with the same Charity ID from database
  void getContracts(String CID) async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('contracts'))
          ..whereEqualTo("cho_id", CID);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allcontracts = apiResponse.results as List<ParseObject>;
      });
    } else {
      allcontracts = [];
    }
  }

  checkStatus() async {
    for (int i = 0; i < allcontracts.length; i++) {
      var contract = allcontracts[i];
      DateTime? end = DateTime.parse(contract.get("End_date"));
      String status = contract.get("contract_status");

      if (end.isBefore(DateTime.now()) && status != "Canceled") {
        //update database
        var ContractStatus = ParseObject('contracts')
          ..objectId = contract.get("objectId")
          ..set('contract_status', "Complete");

        await ContractStatus.save();
      }
    }
  }

  Color? getDynamicColor(String status) {
    if (status == 'Complete') {
      return Colors.green[400];
    } else {
      if (status == 'In Progress') {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkStatus();
    getContracts(Cid);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Hayat food donation',
        ),
        backgroundColor: Colors.teal[200],
        elevation: 0.0,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: allcontracts.length,
            itemBuilder: (context, i) {
              var contract = allcontracts[i];

              if (contract.get('contract_status') == "Complete") {
                status = 'Complete';
              }
              if (contract.get('contract_status') == "In Progress") {
                status = 'In Progress';
              }
              if (contract.get('contract_status') == "Canceled") {
                status = 'Canceled';
              }

              return Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(3, 4))
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => contractDetailesForCharity(
                                  Selectedperiod:
                                      contract.get("contract_type").toString(),
                                  SelectedcontCategory:
                                      contract.get("Food_category").toString(),
                                  SelectedcontStatus:
                                      contract.get("Food_status").toString(),
                                  SelectedAvailableQuantity_c:
                                      contract.get("fquantity").toString(),
                                  SelectedStartDate_c:
                                      contract.get("startDate").toString(),
                                  SelectedEndDate_c:
                                      contract.get("End_date").toString(),
                                )));
                  },
                  title: Text(
                      '\nFood Category: ${contract.get("Food_category").toString()}\n\nFood Status: ${contract.get("Food_status").toString()}\n\nStart Date: ${contract.get("startDate").toString()}\n\nEnd Date: ${contract.get("End_date").toString()}\n\nPeriod:${contract.get("contract_type").toString()}\n\nAvailable Quantity: ${contract.get("fquantity").toString()}\n'),
                  subtitle: Align(
                      alignment: Alignment.bottomRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.mode_standby_outlined,
                                  color: getDynamicColor(status), size: 16),
                            ),
                            TextSpan(
                                text: ' $status       \n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: getDynamicColor(status),
                                    fontSize: 16)),
                          ],
                        ),
                      )),
                ),
              );
            }),
      ),
    );
  }
}
