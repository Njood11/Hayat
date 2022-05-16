import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Contract extends StatefulWidget {
  var Donorid;
  var CID;
  Contract(this.Donorid, this.CID);

  @override
  _Contract createState() => _Contract(Donorid, CID);
}

class _Contract extends State<Contract> {
  var _file;
  var Donorid;
  var CID;
  late int quantity = 1;
  late var inValidEndDate = "";
  _Contract(this.Donorid, this.CID);

//function to add new contract to database
  void addcontracts() async {
    final offer = ParseObject("contracts")
      ..set('Food_category', dropdownvalueCategory + ',' + MoreController.text)
      ..set('Food_status', dropdownvalueStatus)
      ..set('fquantity', quantity)
      ..set('cho_id', CID)
      ..set('donor_id', Donorid)
      ..set('contract_type', dropdownvalueContract)
      ..set('End_date', DateFormat('yyyy-MM-dd').format(pickedDate2))
      ..set('startDate', DateFormat('yyyy-MM-dd').format(pickedDate))
      ..set('contract_status', 'In Progress');
    ;

    var response = await offer.save();
    if (response.success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeD(Donorid)),
      );
    }
    if (response.success == false) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context, 'OK');
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Error!"),
        content: Text("Can't add Contract!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  // Initial Selected Value
  String dropdownvalueAQ = ' 1-5 ';

  // List of items in our dropdown menu

  String dropdownvalueCategory = ' Vegetables ';
  // List of items in our dropdown menu of category
  var itemsCategory = [
    ' Vegetables ',
    ' Fruits ',
    ' Meat ',
    ' Sea Food ',
    ' Bread ',
    ' Legumes ',
    ' Nuts and Seeds ',
    ' Candy ',
    ' Dairy ',
  ];

  String dropdownvalueStatus = ' Frozen ';

  // List of items in our dropdown menu of status
  var itemsStatus = [
    ' Frozen ',
    ' Cooked ',
    ' Canned ',
    ' Chilled ',
    ' Fresh ',
    ' Dried ',
  ];

  String dropdownvalueContract = ' Daily ';

  // List of items in our dropdown menu of status
  var itemsContract = [
    ' Daily ',
    ' Weekly ',
    ' Monthly ',
  ];

  String imagePath = "";
  final picker = ImagePicker();

  late String FoodStatus = " ";
  late String FoodCategory = " ";
  late String Expire = "";
  late String Expire2 = "";
  late String EstimatedQuantity = " ";
  late String More = " ";
  late DateTime pickedDate;
  late DateTime pickedDate2;
  final formKey = GlobalKey<FormState>(); //key for form
  var FoodCategoryController = new TextEditingController();
  var FoodStatusController = new TextEditingController();
  var MoreController = new TextEditingController();

  String? imageUrl;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    pickedDate2 = DateTime.now();
  }

  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: Text('Hayat food donation'),
      ),
      body: SingleChildScrollView(
        padding: new EdgeInsets.only(top: 40, left: 50, right: 50),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Send Contract",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 30,
                  ),
                ],
              ),

//---------------------------Type of contract -------------------------------

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("\n\n Type of contract    \n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      DropdownButton(
                        // Initial Value
                        value: dropdownvalueContract,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: itemsContract.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalueContract = newValue!;
                          });
                        },
                      ),
                    ]),
                  ),
                ],
              ),
//-----------------------------------------------------------------------------

//------------------------- Food Category ------------------------------------

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("\n\n Food Category:      \n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      DropdownButton(
                        // Initial Value
                        value: dropdownvalueCategory,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: itemsCategory.map((String items2) {
                          return DropdownMenuItem(
                            value: items2,
                            child: Text(items2),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalueCategory = newValue!;
                          });
                        },
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      TextFormField(
                          onChanged: (value) {
                            More = value;
                          },
                          controller: MoreController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(),
                            labelText: '  more..',
                          ),
                          validator: (value) {}),
                    ]),
                  ),
                ],
              ),

//-----------------------------------------------------------------------------

//------------------------- Food Status ------------------------------------

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("\n\n Food Status:      \n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      DropdownButton(
                        // Initial Value
                        value: dropdownvalueStatus,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: itemsStatus.map((String items2) {
                          return DropdownMenuItem(
                            value: items2,
                            child: Text(items2),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalueStatus = newValue!;
                          });
                        },
                      ),
                    ]),
                  ),
                ],
              ),

//-----------------------------------------------------------------------------

//------------------------- Available Quantity ------------------------------------

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "\n\n Available quantity:      \n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      TextFormField(
                          onChanged: (value) {
                            var q = int.parse(value);
                            quantity = q;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(),
                            labelText: 'Number of Person',
                          ),
                          validator: (value) {
                            var v = int.parse(value!);

                            if (value == null || value.isEmpty) {
                              return 'Please enter a number';
                            } else if (v.toInt() == false)
                              return 'Enter a valid number';
                          }),
                    ]),
                  ),
                  //
                ],
              ),

//-----------------------------------------------------------------------------
//--------------------- Start and end dates ------------------------------------

              const SizedBox(
                height: 20,
              ),

              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(" Start date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black)),
                  ),
                  ListTile(
                    title: Text(
                        "${pickedDate.year},${pickedDate.month},${pickedDate.day}"),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: _pickedDate,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Expire,
                      style: TextStyle(
                        color: Colors.red.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(" End date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black)),
                  ),
                  ListTile(
                    title: Text(
                        "${pickedDate2.year},${pickedDate2.month},${pickedDate2.day}"),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: _pickedDate2,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Expire2,
                      style: TextStyle(
                        color: Colors.red.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      inValidEndDate,
                      style: TextStyle(
                        color: Colors.red.withOpacity(0.8),
                      ),
                    ),
                  ),
//-----------------------------------------------------------------------------

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: ElevatedButton(
                        onPressed: () async {
                          FoodCategory = FoodCategoryController.text;
                          FoodStatus = FoodStatusController.text;
                          print("start date" + pickedDate.toString());
                          print("End date" + pickedDate2.toString());
                          try {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (formKey.currentState!.validate() &&
                                Expire == '' &&
                                Expire2 == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                              addcontracts();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeD(Donorid)),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text('Send')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//functionns to pick date
  _pickedDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    setState(() {
      pickedDate = date!;
    });
    if (date != null && date.isBefore(DateTime.now())) {
      setState(() {
        pickedDate = date;
        Expire = "Please enter valid date\n";
        inValidEndDate = "";
      });
    }

    if (date != null && date.isAfter(DateTime.now())) {
      if (date.isAfter(pickedDate2) && pickedDate2.isAfter(DateTime.now())) {
        setState(() {
          Expire = "";
          inValidEndDate = "Please enter valid end date\n";
        });
      } else if (date.isBefore(pickedDate2) &&
          pickedDate2.isAfter(DateTime.now())) {
        setState(() {
          Expire = "";
          inValidEndDate = "";
        });
      } else if (date.isAfter(pickedDate2) &&
          pickedDate2.isBefore(DateTime.now())) {
        print('access');
        setState(() {
          Expire = "";
          Expire2 = "Please enter valid date\n";
          inValidEndDate = "";
        });
      }
    }
  }

  _pickedDate2() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: pickedDate2,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    print(date);

    if (date != null && date.isBefore(DateTime.now()))
      setState(() {
        pickedDate2 = date;
        Expire2 = "Please enter valid date\n";
        inValidEndDate = "";
      });

    if (date != null && date.isAfter(DateTime.now())) {
      setState(() {
        pickedDate2 = date;
        Expire2 = "";
      });
      if (date.isBefore(pickedDate))
        setState(() {
          inValidEndDate = "Please enter valid end date\n";
          Expire2 = "";
        });
      if (date.isAfter(pickedDate))
        setState(() {
          inValidEndDate = "";
          Expire2 = "";
        });
    }
  }
}
