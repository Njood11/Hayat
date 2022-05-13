import 'dart:convert';
//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PublishOfferPage extends StatefulWidget {
  var Donorid;
  PublishOfferPage({Key? key, this.Donorid}) : super(key: key);

  @override
  _PublishOfferPage createState() => _PublishOfferPage(Donorid);
}

class _PublishOfferPage extends State<PublishOfferPage> {
  var Donorid;
  PickedFile? pickedFile;
  _PublishOfferPage(this.Donorid);
  void pickC() async {
    PickedFile? image =
        await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      pickedFile = image;
    });
  }

  void addOffer() async {
    final offer = ParseObject("donations")
      ..set("aq", quantity)
      ..set('exp_date', DateFormat('yyyy-MM-dd').format(pickedDate))
      ..set('food_category', dropdownvalueCategory + ',' + MoreController.text)
      ..set('food_status', dropdownvalueStatus)
      ..set('donor_ID', Donorid)
      ..set("pic", parseFile);
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
        content: Text("Can't add offer!"),
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

      pickedFile = null;
    }
  }

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

  final picker = ImagePicker();
  ParseFileBase? parseFile;

  late int quantity = 1;
  late String FoodStatus = " ";
  late String FoodCategory = " ";
  late String Expire = "";
  late String EstimatedQuantity = " ";
  late String More = " ";
  late DateTime pickedDate;
  final formKey = GlobalKey<FormState>(); //key for form
  var FoodCategoryController = new TextEditingController();
  var FoodStatusController = new TextEditingController();
  var MoreController = new TextEditingController();

  String? imageUrl;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
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
                    "Donate now",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 30,
                  ),
                  Text(
                    "\" Giving is not just making a donation,\n    It is about making a differance \"\n\n\n\n",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),

//------------------------- Available Quantity ------------------------------------

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
                ],
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

//-----------------------------------------------------------------------------
              SizedBox(
                height: 15,
              ),
//------------------------- Food Category ------------------------------------

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "\n\n Food Category:      \n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
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
                        isExpanded: true,
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
                    //),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    // see 3
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
              SizedBox(
                height: 15,
              ),
//------------------------- Food Status ------------------------------------

              Column(
                mainAxisSize: MainAxisSize.min, // see 3
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    //  child: Flexible(
                    child: Text(
                      "\n\n Food Status:      \n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    // ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    // child: Flexible(
                    // see 3
                    child: Column(children: <Widget>[
                      DropdownButton(
                        // Initial Value

                        value: dropdownvalueStatus,
                        isExpanded: true,

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
                    //),
                  ),
                ],
              ),

//-----------------------------------------------------------------------------
              const SizedBox(
                height: 30,
              ),
//-------------------------Expiration date ------------------------------------
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "  Expiration date",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
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
//------------------------- Select Image ------------------------------------
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.teal.shade100),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)))),
                      onPressed: () async {
                        pickC();
                      },
                      child: Text(
                        "Select Image",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 280.0,
                      color: Colors.teal[100],
                      child: pickedFile == null
                          ? Text(
                              "No Image Selectd",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            )
                          : Image.file(File(pickedFile!.path))),
//------------------------------------------------------------------------------
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () async {
                            FoodCategory = FoodCategoryController.text;
                            FoodStatus = FoodStatusController.text;

                            try {
                              if (pickedFile == null) {
                                Widget okButton = TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.pop(context, 'OK');
                                  },
                                );
                                // set up the AlertDialog
                                AlertDialog alert = AlertDialog(
                                  title: Text("Error!"),
                                  content: Text(
                                      "Please select an image to continue!"),
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
                              // Validate returns true if the form is valid, or false otherwise.
                              if (formKey.currentState!.validate() &&
                                  Expire == '' &&
                                  pickedFile != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                parseFile = ParseFile(File(pickedFile!.path));
                                await parseFile!.save();

                                addOffer();
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          color: Colors.teal[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Publish",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          splashColor: Colors.red)),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pickedDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (date != null && date.isBefore(DateTime.now()))
      setState(() {
        pickedDate = date;
        Expire = "Please enter valid date";
      });

    if (date != null && date.isAfter(DateTime.now()))
      setState(() {
        pickedDate = date;
        Expire = "";
      });
  }
}
