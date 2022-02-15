import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hayat_gp2_18/database/sqlite.dart';
import 'package:hayat_gp2_18/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class PublishOfferPage extends StatefulWidget {
  PublishOfferPage({Key? key}) : super(key: key);

  @override
  _PublishOfferPage createState() => _PublishOfferPage();
}

class _PublishOfferPage extends State<PublishOfferPage> {
  var _file;

  void pickC() async {
    var picFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _file = File(picFile!.path);
    });
  }

  Future encodePic() async {
    if (_file == null) return;

    String base64 = base64Encode(_file.readAsBytesSync());
  }

  // Initial Selected Value
  String dropdownvalueAQ = ' 1-5 ';

  // List of items in our dropdown menu
  var items = [
    ' 1-5 ',
    ' 6-10 ',
    ' 11-20 ',
    ' 21-30 ',
    ' 31-40 ',
    ' more than 40 ',
  ];

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
  //uploadImage() async {}
  String imagePath = "";
  final picker = ImagePicker();
  // late String uid = widget.id;
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
  //food category, status, picture, estimated quantity (number of persons)

  String? imageUrl;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: Text('Hayat food donation'),
      ),
      body: SingleChildScrollView(
        //اول تعديل لوديث الانبت
        padding: new EdgeInsets.only(top: 40, left: 50, right: 50),
        child: Form(
          key: formKey,
          //padding: EdgeInsets.symmetric(horizontal: 40),
          //height: MediaQuery.of(context).size.height - 50,
          //width: double.infinity,

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

//------------------------- Food Category ------------------------------------

              Column(
                mainAxisSize: MainAxisSize.min, // see 3
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    //  child: Flexible(
                    child: Text(
                      "\n\n Food Category:      \n",
                    ),
                    // ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min, // see 3
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    // child: Flexible(
                    // see 3
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

//------------------------- Available Quantity ------------------------------------

              Column(
                mainAxisSize: MainAxisSize.min, // see 3
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    //  child: Flexible(
                    child: Text(
                      "\n\n Available quantity (number of person):      \n",
                    ),
                    // ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min, // see 3
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    // child: Flexible(
                    // see 3
                    child: Column(children: <Widget>[
                      DropdownButton(
                        // Initial Value

                        value: dropdownvalueAQ,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalueAQ = newValue!;
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
                height: 20,
              ),

              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "  Expiration date",
                      style: TextStyle(
                        color: Colors.black,
                      ),
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
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.teal.shade200),
                      ),
                      onPressed: () async {
                        pickC();
                        encodePic();
                      },
                      child: Text("Select Image"),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 280.0,
                    color: Colors.teal[200],
                    child: _file == null
                        ? Text(
                            "No Image Selectd",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          )
                        : Image.file(_file),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: ElevatedButton(
                        onPressed: () async {
                          FoodCategory = FoodCategoryController.text;
                          FoodStatus = FoodStatusController.text;

                          try {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (formKey.currentState!.validate() &&
                                Expire == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );

                              var offer = Offers(
                                aq: dropdownvalueAQ,
                                eDate:
                                    DateFormat('yyyy-MM-dd').format(pickedDate),
                                fCategory: dropdownvalueCategory +
                                    ',' +
                                    MoreController.text,
                                fStatus: dropdownvalueStatus,
                                pic: _file.path.split("/").last,
                              );

                              await DatabaseHelper.instance.addOffer(offer);

                              print(await DatabaseHelper.instance.getOffers());

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeD()),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text('Publish')),
                  ),
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

// we will be creating a widget for text field
Widget inputFile({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
    ],
  );
}
