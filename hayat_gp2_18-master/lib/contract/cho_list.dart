import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/contract/contract_form.dart';
//import 'package:hayat_gp2_18/database/sqlite.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/offers/donation_details_d.dart';
import 'package:hayat_gp2_18/offers/offer_details.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class listCHO extends StatefulWidget {
  listCHO(did, {Key? key, this.Did}) : super(key: key);
  var Did;

  @override
  _listCHO createState() => _listCHO(this.Did);
}

class _listCHO extends State<listCHO> {
  List<ParseObject> allCHO = <ParseObject>[];
  var Did;
  _listCHO(this.Did);

  void getCHOs() async {
    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery())
          ..whereEqualTo("userType", 'cho');

    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allCHO = apiResponse.results as List<ParseObject>;
      });
    } else {
      allCHO = [];
    }
    print('cho');
    print(allCHO);
  }

  @override
  void initState() {
    super.initState();
    getCHOs();
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
            itemCount: allCHO.length,
            itemBuilder: (context, i) {
              var cho = allCHO[i];
              print(cho);
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
                    //      print('heyy' + Did);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Contract(
                                  Donorid: Did,
                                )));
                    print('id' + Did);
                  },
                  leading: const Icon(Icons.home_work_rounded),
                  //  fit: BoxFit.cover,
                  //  height: 100,

                  title: Text(
                      '\n\nCharity Name:${cho.get("name").toString()}\n\nPhone number:${cho.get("phone").toString()}\n\nLicense Number:${cho.get("lNumber").toString()}\n'),
                  subtitle: Text('Email: ' + cho.get("username").toString()),
                ),
              );
            }),
      ),
    );
  }
}
