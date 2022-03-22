/*import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/cho_home.dart';
import 'package:hayat_gp2_18/database/sqlite.dart';
import 'package:hayat_gp2_18/offers/offer_details.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/offers/publish_offer.dart';
import 'package:hayat_gp2_18/main.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ListOffersPage3 extends StatefulWidget {
  var myArray;
  var myArray2S;
  var myArray2C;
  var Cid;
  var apply;
  var AllCategory;
  var SelectCategory;
  var selectstatus;

  ListOffersPage3(
      {Key? key,
      this.myArray,
      this.apply,
      this.AllCategory,
      this.myArray2S,
      this.myArray2C,
      this.selectstatus,
      this.SelectCategory,
      this.Cid})
      : super(key: key);
  @override
  _ListOffersPage3 createState() => _ListOffersPage3(myArray, apply,
      AllCategory, myArray2S, myArray2C, selectstatus, SelectCategory, Cid);
}

class _ListOffersPage3 extends State<ListOffersPage3> {
  List<ParseObject> allOffers = <ParseObject>[];
  var myArray;
  var apply;
  var AllCategory;
  var myArray2S;
  var myArray2C;
  var SelectCategory;
  var selectstatus;
  var Cid;
  _ListOffersPage3(this.myArray, this.apply, this.AllCategory, this.myArray2S,
      this.myArray2C, this.selectstatus, this.SelectCategory, this.Cid);
  // late String searchText = searchController.text;
  //late var allOffers = [];
  var items = [];
  var match = [];
  TextEditingController searchController = new TextEditingController();
  late String Searchstring = "";

  @override
  void initState() {
    super.initState();

    getOffers();
  }

  void getOffers() async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('donations'))
          ..whereEqualTo("requested", false);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allOffers = apiResponse.results as List<ParseObject>;
        items = allOffers as List<ParseObject>;
      });
      search("", apply, myArray);
    } else {
      allOffers = [];
    }
    print(items);
  }

  void search1(String query) async {
    var s = allOffers;
    if (query.isNotEmpty) {
      match = [];

      for (int i = 0; i < allOffers.length; i++) {
        // var offer = Offers.fromMap(element);
        var offer = allOffers[i];

        var categories = offer.get("food_category").toString();
        var status = offer.get("food_status").toString();

        if (categories.toLowerCase().contains(query.toLowerCase()) ||
            status.toLowerCase().contains(query.toLowerCase())) {
          match.add(offer);
          print('yes match');
        }
      }

      setState(() {
        items = [];
        items.addAll(match);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allOffers;
      });
    }
  }

  void search(String query, var applay, var myAr) async {
    print('apply: ');
    print(applay);
    print('my filters:');
    print(myAr);

    var s = allOffers;
    if (query.isNotEmpty) {
      match = [];

      for (int i = 0; i < allOffers.length; i++) {
        // var offer = Offers.fromMap(element);
        var offer = allOffers[i];

        var categories = offer.get("food_category").toString();
        var status = offer.get("food_status").toString();

        if (categories.toLowerCase().contains(query.toLowerCase()) ||
            status.toLowerCase().contains(query.toLowerCase())) {
          match.add(offer);
          print('yes match');
        }
      }

      setState(() {
        items = [];
        items.addAll(match);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allOffers;
      });
    }

    if (myAr == null && apply == false) {
      print('Emptyyy');
      setState(() {
        items = [];

        items = allOffers;
      });
    }
    if (AllCategory == true && selectstatus == false) {
      print('Emptyyy');
      setState(() {
        items = [];
        items = allOffers;
      });
    }
    if (AllCategory == true && selectstatus == true) {
      setState(() {
        items = [];
        items = myArray2S;
      });
    }

    if (SelectCategory == true && selectstatus == true) {
      setState(() {
        items = [];
        items = myAr;
      });
    }

    if (SelectCategory == true && selectstatus == false) {
      setState(() {
        items = [];
        items = myArray2C;
      });
    }

    if (SelectCategory == false && selectstatus == true) {
      setState(() {
        items = [];
        items = myArray2S;
      });
    } /*else if (apply == true && myAr != null) {
      setState(() {
        items = myAr;
        print('items:');
        print(myAr);
      });
      return;
    }*/
  }

  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeC(Cid)));
          },
          icon: Icon(Icons.home_outlined),
        ),
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          // search(value, apply, myArray);
                          search(value, apply, myArray);
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Offers..',
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment
                        .topLeft, //mainAxisAlignment: MainAxisAlignment.,
                    child: FlatButton(
                      onPressed: () => {
                        data = showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog();
                            }),
                      },
                      color: Colors.teal[200],
                      padding: EdgeInsets.all(0),
                      child: Column(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[Icon(Icons.filter_alt_outlined)],
                      ),
                    )),
                Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        var offer = items[i];
                        print(offer);

                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
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
                                      builder: (context) => offerDetailes(
                                          SelectedOfferCategory: offer
                                              .get("food_category")
                                              .toString(),
                                          SelectedOfferStatus: offer
                                              .get("food_status")
                                              .toString(),
                                          SelectedAvailableQuantity:
                                              offer.get("aq").toString(),
                                          SelectedExpirationDate:
                                              offer.get("exp_date").toString(),
                                          SelectedPic:
                                              offer.get("pic").toString(),
                                          SelectedDonorId:
                                              offer.get("donor_ID").toString(),
                                          SelectedOfferId:
                                              offer.get("objectId").toString(),
                                          SelectedCHOId: Cid)));
                            },
                            /* leading:   Image.network(
                          offer.pic,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 100,
                        ),*/
                            title: Text(
                                'Food Category:${offer.get("food_category").toString()}\n\nFood Status:${offer.get("food_status").toString()}\n\nEXP:${offer.get("exp_date").toString()}\n'),
                            subtitle: Text('Available Quantity' +
                                offer.get("aq").toString()),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<ParseObject> allOffers = <ParseObject>[];

  late bool Checked1Vegetables = false;
  late bool Checked2Fruits = false;
  late bool Checked3Meat = false;
  late bool Checked4Sea = false;
  late bool Checked5Bread = false;
  late bool Checked6Legumes = false;
  late bool Checked7Nuts = false;
  late bool Checked8Candy = false;
  late bool Checked8Dairy = false;
  late bool Checked9 = false;

  late bool Checked1Frozen = false;
  late bool Checked2Cooked = false;
  late bool Checked3Canned = false;
  late bool Checked4Chilled = false;
  late bool Checked5Fresh = false;
  late bool Checked6Dried = false;

  var SelectedCategory = [];
  var SelectedStatus = [];
  //late var allOffers = [];
  var items = [];
  var matchC = [];
  var matchS = [];
  var finalMatch = [];
  bool selectStatus2 = false;
  bool selectCategory2 = false;
  late var allOffers2 = [];
  void getOffers() async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('donations'))
          ..whereEqualTo("requested", false);
    ;

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allOffers = apiResponse.results as List<ParseObject>;
        items = allOffers as List<ParseObject>;
      });
    } else {
      allOffers = [];
    }
    print(items);
  }

  @override
  void initState() {
    super.initState();

    getOffers();
  }

  void searchWithFilter(var SelectedCat, var SelectedSta) async {
    var SelectedCategories = SelectedCat;

    var query;
    for (int i = 0; i < SelectedCat.length; i++) {
      query = SelectedCat[i];
      print('query');

      print(query);
      var s = allOffers;
      if (query.isNotEmpty) {
        for (int i = 0; i < allOffers.length; i++) {
          // var offer = Offers.fromMap(element);
          var offer = allOffers[i];

          var categories = offer.get("food_category").toString();
          if (categories.toLowerCase().contains(query.toLowerCase())) {
            matchC.add(offer);
          }
        }

        print(matchC);
      }
    }
    var query2;
    var query4;
    var query5;
    var finalQueryC;
    var finalQueryS;
    var SelectedStatus = SelectedSta;
    print(SelectedSta);

    for (int i = 0; i < SelectedSta.length; i++) {
      query2 = SelectedSta[i];
      print('query');

      print(query2);
      var s = allOffers;
      if (query2.isNotEmpty) {
        for (int i = 0; i < allOffers.length; i++) {
          var offer = allOffers[i];

          var status = offer.get("food_status").toString();

          if (status.toLowerCase().contains(query2.toLowerCase())) {
            matchS.add(offer);
          }
        }

        print('matchSsssss');

        print(matchS);
      }
    }

    if (SelectedCategory.contains('Vegetables') ||
        SelectedCategory.contains('Fruits') ||
        SelectedCategory.contains('Meat') ||
        SelectedCategory.contains('Sea Food') ||
        SelectedCategory.contains('Bread') ||
        SelectedCategory.contains('Legumes') ||
        SelectedCategory.contains('Nuts and Seeds') ||
        SelectedCategory.contains('Candy') ||
        SelectedCategory.contains('Dairy')) {
      selectCategory2 = true;
    } else {
      selectCategory2 = false;
    }
    if (SelectedStatus.contains('Frozen') ||
        SelectedStatus.contains('Cooked') ||
        SelectedStatus.contains('Canned') ||
        SelectedStatus.contains('Chilled') ||
        SelectedStatus.contains('Fresh') ||
        SelectedStatus.contains('Dried')) {
      selectStatus2 = true;
    } else {
      selectStatus2 = false;
    }
    print('match C');
    print(matchC);
    print('match S');
    print(matchS);
    print('select category:  ');
    print(selectCategory2);
    print('select status:  ');
    print(selectStatus2);
    print('select category:  ');
    print(SelectedCat);
    print('select status:  ');
    print(SelectedSta);
    int a = SelectedCat.length;
    int b = SelectedSta.length;
    int grater;
    int smaller;

    print(a);
    print(b);

    int c = 0;
    if (a > b) {
      grater = SelectedCat.length;
      smaller = SelectedSta.length;
    } else {
      grater = SelectedSta.length;
      smaller = SelectedCat.length;
    }
    print('grater');
    print(grater);
    print('smaller');
    print(smaller);
//[vegetables,meat] [frozrn]
//[veg] []
    for (int i = 0; i < grater; i++) {
      if (grater == SelectedCat.length) {
        query4 = SelectedCat[i];
        finalQueryC = query4;
      } else {
        query4 = SelectedSta[i];
        finalQueryS = SelectedSta[i];
      }

      for (int j = 0; j < smaller; j++) {
        if (smaller == SelectedSta.length) {
          query5 = SelectedSta[j];
          finalQueryS = SelectedSta[j];
        } else {
          query5 = SelectedCat[j];
          finalQueryC = SelectedCat[j];
        }

        print('finalQueryC');
        print(finalQueryC);
        print('finalQueryS');
        print(finalQueryS);

        var s12 = allOffers;
        finalMatch = [];
        for (int i = 0; i < allOffers.length; i++) {
          var offer = allOffers[i];
          var categories = offer.get("food_category").toString();
          print('categories');
          print(categories);
          var status = offer.get("food_status").toString();
          print('status');
          print(status);
          if (categories.toLowerCase().contains(finalQueryC.toLowerCase()) &&
              status.toLowerCase().contains(finalQueryS.toLowerCase())) {
            print('yeass match');
            finalMatch.add(offer);
          }
        }

        print('final match :');
        print(finalMatch);
      }
    }
  }

  var apply = false;
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: Text(
                        'Category',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.teal[200],
                            ),
                      ),
                    ),
                  ),
                  Column(
                    //height: 25,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CheckboxListTile(
                        title: Text("Vegetables"), //    <-- label
                        value: Checked1Vegetables,
                        onChanged: (newValue) {
                          setState(() {
                            Checked1Vegetables = newValue!;
                          });
                          if (Checked1Vegetables) {
                            SelectedCategory.add('Vegetables');
                            print(SelectedCategory);
                          } else if (!Checked1Vegetables) {
                            SelectedCategory.remove('Vegetables');
                            print(SelectedCategory);
                          }
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                      CheckboxListTile(
                        title: Text("Fruits"), //    <-- label
                        value: Checked2Fruits,
                        onChanged: (newValue) {
                          setState(() {
                            Checked2Fruits = newValue!;
                          });
                          if (Checked2Fruits) {
                            SelectedCategory.add('Fruits');
                            print(SelectedCategory);
                          } else if (!Checked2Fruits) {
                            SelectedCategory.remove('Fruits');
                            print(SelectedCategory);
                          }
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                      CheckboxListTile(
                        title: Text("Meat"), //    <-- label
                        value: Checked3Meat,
                        onChanged: (newValue) {
                          setState(() {
                            Checked3Meat = newValue!;
                          });
                          if (Checked3Meat) {
                            SelectedCategory.add('Meat');
                            print(SelectedCategory);
                          } else if (!Checked3Meat) {
                            SelectedCategory.remove('Meat');
                            print(SelectedCategory);
                          }
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                      CheckboxListTile(
                        title: Text("Sea Food"), //    <-- label
                        value: Checked4Sea,
                        onChanged: (newValue) {
                          setState(() {
                            Checked4Sea = newValue!;
                          });
                          if (Checked4Sea) {
                            SelectedCategory.add('Sea Food');
                            print(SelectedCategory);
                          } else if (!Checked4Sea) {
                            SelectedCategory.remove('Sea Food');
                            print(SelectedCategory);
                          }
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                      CheckboxListTile(
                        title: Text("Bread"), //    <-- label
                        value: Checked5Bread,
                        onChanged: (newValue) {
                          setState(() {
                            Checked5Bread = newValue!;
                          });
                          if (Checked5Bread) {
                            SelectedCategory.add('Bread');
                            print(SelectedCategory);
                          } else if (!Checked5Bread) {
                            SelectedCategory.remove('Bread');
                            print(SelectedCategory);
                          }
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                      CheckboxListTile(
                        title: Text("Legumes"), //    <-- label
                        value: Checked6Legumes,
                        onChanged: (newValue) {
                          setState(() {
                            Checked6Legumes = newValue!;
                          });
                          if (Checked6Legumes) {
                            SelectedCategory.add('Legumes');
                            print(SelectedCategory);
                          } else if (!Checked6Legumes) {
                            SelectedCategory.remove('Legumes');
                            print(SelectedCategory);
                          }
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                      CheckboxListTile(
                        title: Text("Nuts and Seeds"), //    <-- label
                        value: Checked7Nuts,
                        onChanged: (newValue) {
                          setState(() {
                            Checked7Nuts = newValue!;
                          });
                          if (Checked7Nuts) {
                            SelectedCategory.add('Nuts and Seeds');
                            print(SelectedCategory);
                          } else if (!Checked7Nuts) {
                            SelectedCategory.remove('Nuts and Seeds');
                            print(SelectedCategory);
                          }
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                      CheckboxListTile(
                        title: Text("Candy"), //    <-- label
                        value: Checked8Candy,
                        onChanged: (newValue) {
                          setState(() {
                            Checked8Candy = newValue!;
                          });
                          if (Checked8Candy) {
                            SelectedCategory.add('Candy');
                            print(SelectedCategory);
                          } else if (!Checked8Candy) {
                            SelectedCategory.remove('Candy');
                            print(SelectedCategory);
                          }
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                      CheckboxListTile(
                        title: Text("Dairy"), //    <-- label
                        value: Checked8Dairy,
                        onChanged: (newValue) {
                          setState(() {
                            Checked8Dairy = newValue!;
                          });
                          if (Checked8Dairy) {
                            SelectedCategory.add('Dairy');
                            print(SelectedCategory);
                          } else if (!Checked8Dairy) {
                            SelectedCategory.remove('Dairy');
                            print(SelectedCategory);
                          }
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                      CheckboxListTile(
                        title: Text("All"), //    <-- label
                        value: Checked9,
                        onChanged: (newValue) {
                          setState(() {
                            Checked9 = newValue!;
                          });
                        },
                        activeColor: Colors.tealAccent[200],
                        checkColor: Colors.black87,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: Text(
                        'Status',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.teal[200],
                            ),
                      ),
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckboxListTile(
                          title: Text("Frozen"), //    <-- label
                          value: Checked1Frozen,
                          onChanged: (newValue) {
                            setState(() {
                              Checked1Frozen = newValue!;
                            });
                            if (Checked1Frozen) {
                              SelectedStatus.add('Frozen');
                              print(SelectedStatus);
                            } else if (!Checked1Frozen) {
                              SelectedStatus.remove('Frozen');
                              print(SelectedStatus);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Cooked"), //    <-- label
                          value: Checked2Cooked,
                          onChanged: (newValue) {
                            setState(() {
                              Checked2Cooked = newValue!;
                            });
                            if (Checked2Cooked) {
                              SelectedStatus.add('Cooked');
                              print(SelectedStatus);
                            } else if (!Checked2Cooked) {
                              SelectedStatus.remove('Cooked');
                              print(SelectedStatus);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Canned"), //    <-- label
                          value: Checked3Canned,
                          onChanged: (newValue) {
                            setState(() {
                              Checked3Canned = newValue!;
                            });
                            if (Checked3Canned) {
                              SelectedStatus.add('Canned');
                              print(SelectedStatus);
                            } else if (!Checked3Canned) {
                              SelectedStatus.remove('Canned');
                              print(SelectedStatus);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Chilled"), //    <-- label
                          value: Checked4Chilled,
                          onChanged: (newValue) {
                            setState(() {
                              Checked4Chilled = newValue!;
                            });
                            if (Checked4Chilled) {
                              SelectedStatus.add('Chilled');
                              print(SelectedStatus);
                            } else if (!Checked4Chilled) {
                              SelectedStatus.remove('Chilled');
                              print(SelectedStatus);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Fresh"), //    <-- label
                          value: Checked5Fresh,
                          onChanged: (newValue) {
                            setState(() {
                              Checked5Fresh = newValue!;
                            });
                            if (Checked5Fresh) {
                              SelectedStatus.add('Fresh');
                              print(SelectedStatus);
                            } else if (!Checked5Fresh) {
                              SelectedStatus.remove('Fresh');
                              print(SelectedStatus);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Dried"), //    <-- label
                          value: Checked6Dried,
                          onChanged: (newValue) {
                            setState(() {
                              Checked6Dried = newValue!;
                            });
                            if (Checked6Dried) {
                              SelectedStatus.add('Dried');
                              print(SelectedStatus);
                            } else if (!Checked6Dried) {
                              SelectedStatus.remove('Dried');
                              print(SelectedStatus);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                      ])
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  searchWithFilter(SelectedCategory, SelectedStatus);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListOffersPage3(
                            myArray: finalMatch,
                            myArray2S: matchS,
                            myArray2C: matchC,
                            apply: true,
                            AllCategory: Checked9,
                            SelectCategory: selectCategory2,
                            selectstatus: selectStatus2,
                          )),
                );
                //String text = "Data that we want to pass. Can be anything.";
                // Navigator.pop(context, match);
              },
              child: const Text('Apply')),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/cho_home.dart';
import 'package:hayat_gp2_18/database/sqlite.dart';
import 'package:hayat_gp2_18/offers/offer_details.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/offers/publish_offer.dart';
import 'package:hayat_gp2_18/main.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ListOffersPage3 extends StatefulWidget {
  var myArray;
  var myArray2S;
  var myArray2C;
  var myArray2A;
  var Cid;
  var apply;
  var AllCategory;
  var SelectCategory;
  var selectstatus;
  var selectQuantity;
  ListOffersPage3(
      {Key? key,
      this.myArray,
      this.apply,
      this.AllCategory,
      this.myArray2S,
      this.myArray2C,
      this.myArray2A,
      this.selectstatus,
      this.SelectCategory,
      this.selectQuantity,
      this.Cid})
      : super(key: key);
  @override
  _ListOffersPage3 createState() => _ListOffersPage3(
      myArray,
      apply,
      AllCategory,
      myArray2S,
      myArray2C,
      myArray2A,
      selectQuantity,
      selectstatus,
      SelectCategory,
      Cid);
}

class _ListOffersPage3 extends State<ListOffersPage3> {
  List<ParseObject> allOffers = <ParseObject>[];
  var myArray;
  var apply;
  var AllCategory;
  var myArray2S;
  var myArray2C;
  var myArray2A;
  var SelectCategory;
  var selectstatus;
  var selectQuantity;
  var Cid;
  _ListOffersPage3(
      this.myArray,
      this.apply,
      this.AllCategory,
      this.myArray2S,
      this.myArray2C,
      this.myArray2A,
      this.selectstatus,
      this.selectQuantity,
      this.SelectCategory,
      this.Cid);
  // late String searchText = searchController.text;
  //late var allOffers = [];
  var items = [];
  var match = [];
  TextEditingController searchController = new TextEditingController();
  late String Searchstring = "";

  @override
  void initState() {
    super.initState();

    getOffers();
  }

  void getOffers() async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('donations'))
          ..whereEqualTo("requested", false);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allOffers = apiResponse.results as List<ParseObject>;
        items = allOffers as List<ParseObject>;
      });
      search("", apply, myArray);
    } else {
      allOffers = [];
    }
    print(items);
  }

  void search1(String query) async {
    var s = allOffers;
    if (query.isNotEmpty) {
      match = [];

      for (int i = 0; i < allOffers.length; i++) {
        // var offer = Offers.fromMap(element);
        var offer = allOffers[i];

        var categories = offer.get("food_category").toString();
        var status = offer.get("food_status").toString();

        if (categories.toLowerCase().contains(query.toLowerCase()) ||
            status.toLowerCase().contains(query.toLowerCase())) {
          match.add(offer);
          print('yes match');
        }
      }

      setState(() {
        items = [];
        items.addAll(match);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allOffers;
      });
    }
  }

  void search(String query, var applay, var myAr) async {
    print('apply: ');
    print(applay);
    print('my filters:');
    print(myAr);

    var s = allOffers;
    if (query.isNotEmpty) {
      match = [];

      for (int i = 0; i < allOffers.length; i++) {
        // var offer = Offers.fromMap(element);
        var offer = allOffers[i];

        var categories = offer.get("food_category").toString();
        var status = offer.get("food_status").toString();
        var Quantity = offer.get("available_quantity").toString();

        if (categories.toLowerCase().contains(query.toLowerCase()) ||
            status.toLowerCase().contains(query.toLowerCase()) ||
            Quantity.toLowerCase().contains(query.toLowerCase())) {
          match.add(offer);
          print('yes match');
        }
      }

      setState(() {
        items = [];
        items.addAll(match);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allOffers;
      });
    }

    if (myAr == null && apply == false) {
      print('Emptyyy');
      setState(() {
        items = [];

        items = allOffers;
      });
    }
    if (AllCategory == true &&
        selectstatus == false &&
        selectQuantity == false) {
      print('Emptyyy');
      setState(() {
        items = [];
        items = allOffers;
      });
    }
    if (AllCategory == true &&
        selectstatus == true &&
        selectQuantity == false) {
      setState(() {
        items = [];
        items = myArray2S;
      });
    }

    if (SelectCategory == true &&
        selectstatus == true &&
        selectQuantity == true) {
      setState(() {
        items = [];
        items = myAr;
      });
    }

    if (SelectCategory == true &&
        selectstatus == false &&
        selectQuantity == false) {
      setState(() {
        items = [];
        items = myArray2C;
      });
    }

    if (SelectCategory == false &&
        selectstatus == true &&
        selectQuantity == false) {
      setState(() {
        items = [];
        items = myArray2S;
      });
    }

    if (SelectCategory == false &&
        selectstatus == false &&
        selectQuantity == true) {
      setState(() {
        items = [];
        items = myArray2A;
      });
    }

    /*else if (apply == true && myAr != null) {
      setState(() {
        items = myAr;
        print('items:');
        print(myAr);
      });
      return;
    }*/
  }

  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeC(Cid)));
          },
          icon: Icon(Icons.home_outlined),
        ),
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          // search(value, apply, myArray);
                          search(value, apply, myArray);
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Offers..',
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment
                        .topLeft, //mainAxisAlignment: MainAxisAlignment.,
                    child: FlatButton(
                      onPressed: () => {
                        data = showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog();
                            }),
                      },
                      color: Colors.teal[200],
                      padding: EdgeInsets.all(0),
                      child: Column(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[Icon(Icons.filter_alt_outlined)],
                      ),
                    )),
                Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        var offer = items[i];
                        print(offer);

                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
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
                                      builder: (context) => offerDetailes(
                                          SelectedOfferCategory: offer
                                              .get("food_category")
                                              .toString(),
                                          SelectedOfferStatus: offer
                                              .get("food_status")
                                              .toString(),
                                          SelectedAvailableQuantity:
                                              offer.get("aq").toString(),
                                          SelectedExpirationDate:
                                              offer.get("exp_date").toString(),
                                          SelectedPic:
                                              offer.get("pic").toString(),
                                          SelectedDonorId:
                                              offer.get("donor_ID").toString(),
                                          SelectedOfferId:
                                              offer.get("objectId").toString(),
                                          SelectedCHOId: Cid)));
                            },
                            /* leading:   Image.network(
                          offer.pic,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 100,
                        ),*/
                            title: Text(
                                'Food Category:${offer.get("food_category").toString()}\n\nFood Status:${offer.get("food_status").toString()}\n\nEXP:${offer.get("exp_date").toString()}\n'),
                            subtitle: Text('Available Quantity' +
                                offer.get("aq").toString()),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<ParseObject> allOffers = <ParseObject>[];

  late bool Checked1Vegetables = false;
  late bool Checked2Fruits = false;
  late bool Checked3Meat = false;
  late bool Checked4Sea = false;
  late bool Checked5Bread = false;
  late bool Checked6Legumes = false;
  late bool Checked7Nuts = false;
  late bool Checked8Candy = false;
  late bool Checked8Dairy = false;
  late bool Checked9 = false;

  late bool Checked1Frozen = false;
  late bool Checked2Cooked = false;
  late bool Checked3Canned = false;
  late bool Checked4Chilled = false;
  late bool Checked5Fresh = false;
  late bool Checked6Dried = false;

  late bool Checked1 = false;
  late bool Checked2 = false;
  late bool Checked3 = false;
  late bool Checked4 = false;
  late bool Checked5 = false;
  late bool Checked6 = false;

  var SelectedCategory = [];
  var SelectedStatus = [];
  var SelectedQuantity = [];
  //late var allOffers = [];
  var items = [];
  var matchC = [];
  var matchS = [];
  var matchA = [];
  var finalMatch = [];
  bool selectStatus2 = false;
  bool selectCategory2 = false;
  bool selectQuantity2 = false;
  late var allOffers2 = [];
  void getOffers() async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('donations'))
          ..whereEqualTo("requested", false);
    ;

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allOffers = apiResponse.results as List<ParseObject>;
        items = allOffers as List<ParseObject>;
      });
    } else {
      allOffers = [];
    }
    print(items);
  }

  @override
  void initState() {
    super.initState();

    getOffers();
  }

  void searchWithFilter(var SelectedCat, var SelectedSta, var SelectQua) async {
    var SelectedCategories = SelectedCat;

    var query;
    for (int i = 0; i < SelectedCat.length; i++) {
      query = SelectedCat[i];
      print('query');

      print(query);
      var s = allOffers;
      if (query.isNotEmpty) {
        for (int i = 0; i < allOffers.length; i++) {
          // var offer = Offers.fromMap(element);
          var offer = allOffers[i];

          var categories = offer.get("food_category").toString();
          if (categories.toLowerCase().contains(query.toLowerCase())) {
            matchC.add(offer);
          }
        }

        print(matchC);
      }
    }
    var query2;
    var query4;
    var query5;
    var quert6;
    var finalQueryC;
    var finalQueryS;
    var finalQueryA;
    var SelectedStatus = SelectedSta;
    print(SelectedSta);

    for (int i = 0; i < SelectedSta.length; i++) {
      query2 = SelectedSta[i];
      print('query');

      print(query2);
      var s = allOffers;
      if (query2.isNotEmpty) {
        for (int i = 0; i < allOffers.length; i++) {
          var offer = allOffers[i];

          var status = offer.get("food_status").toString();

          if (status.toLowerCase().contains(query2.toLowerCase())) {
            matchS.add(offer);
          }
        }

        print('matchSsssss');

        print(matchS);
      }
    }
    //quantity
    var SelectedQuantity = SelectQua;

    var queryQ;
    for (int i = 0; i < SelectQua.length; i++) {
      query = SelectQua[i];
      print('queryQ');

      print(queryQ);
      var s = allOffers;
      if (queryQ.isNotEmpty) {
        for (int i = 0; i < allOffers.length; i++) {
          // var offer = Offers.fromMap(element);
          var offer = allOffers[i];

          var quantity = offer.get("available_quantity").toString();
          if (quantity.toLowerCase().contains(query.toLowerCase())) {
            matchA.add(offer);
          }
        }

        print(matchA);
      }
    }
    if (SelectedCategory.contains('Vegetables') ||
        SelectedCategory.contains('Fruits') ||
        SelectedCategory.contains('Meat') ||
        SelectedCategory.contains('Sea Food') ||
        SelectedCategory.contains('Bread') ||
        SelectedCategory.contains('Legumes') ||
        SelectedCategory.contains('Nuts and Seeds') ||
        SelectedCategory.contains('Candy') ||
        SelectedCategory.contains('Dairy')) {
      selectCategory2 = true;
    } else {
      selectCategory2 = false;
    }
    if (SelectedStatus.contains('Frozen') ||
        SelectedStatus.contains('Cooked') ||
        SelectedStatus.contains('Canned') ||
        SelectedStatus.contains('Chilled') ||
        SelectedStatus.contains('Fresh') ||
        SelectedStatus.contains('Dried')) {
      selectStatus2 = true;
    } else {
      selectStatus2 = false;
    }
    //Quantity
    if (SelectedQuantity.contains(' 1-5 ') ||
        SelectedQuantity.contains('6-10') ||
        SelectedQuantity.contains('11-20 ') ||
        SelectedQuantity.contains('21-30') ||
        SelectedQuantity.contains('31-40') ||
        SelectedQuantity.contains('more than 40')) {
      selectQuantity2 = true;
    } else {
      selectQuantity2 = false;
    }
    print('match C');
    print(matchC);
    print('match S');
    print(matchS);
    print('match A');
    print(matchA);
    print('select category:  ');
    print(selectCategory2);
    print('select status:  ');
    print(selectStatus2);
    print('select available quantity  :');
    print(selectQuantity2);
    print('select category:  ');
    print(SelectedCat);
    print('select status:  ');
    print(SelectedSta);
    print('select available quantity  :');
    print(SelectQua);
    // هنا ركزي
    int a = SelectedCat.length;
    int b = SelectedSta.length;
    int q = SelectQua.length;
    int grater;
    int smaller;
    int smaller1;

    print(a);
    print(b);
    print(q);

    int c = 0;
    if (a > b && a > q) {
      grater = SelectedCat.length;
      smaller = SelectedSta.length;
      smaller1 = SelectQua.length;
    } else if (b > a && b > q) {
      grater = SelectedSta.length;
      smaller = SelectedCat.length;
      smaller1 = SelectQua.length;
    } else {
      grater = SelectQua.length;
      smaller = SelectedCat.length;
      smaller1 = SelectedSta.length;
    }
    print('grater');
    print(grater);
    print('smaller');
    print(smaller);
    print('smller1');
    print(smaller1);
//[vegetables,meat] [frozrn]
//[veg] []
    for (int i = 0; i < grater; i++) {
      if (grater == SelectedCat.length) {
        query4 = SelectedCat[i];
        finalQueryC = query4;
      } else if (grater == SelectedSta.length) {
        query4 = SelectedSta[i];
        finalQueryS = SelectedSta[i];
      } else {
        query4 = SelectQua[i];
        finalQueryA = query4;
      }

      for (int j = 0; j < smaller; j++) {
        if (smaller == SelectedSta.length) {
          query5 = SelectedSta[j];
          finalQueryS = SelectedSta[j];
        } else if (smaller == SelectedCat.length) {
          query5 = SelectedCat[j];
          finalQueryC = SelectedCat[j];
        } else {
          query5 = SelectQua[j];
          finalQueryA = SelectQua[j];
        }
        //
        for (int j = 0; j < smaller1; j++) {
          if (smaller1 == SelectQua.length) {
            quert6 = SelectQua[j];
            finalQueryA = SelectQua[j];
          } else if (smaller1 == SelectedCat.length) {
            quert6 = SelectedCat[j];
            finalQueryC = SelectedCat[j];
          } else {
            quert6 = SelectedSta[j];
            finalQueryS = SelectedSta[j];
          }
          print('finalQueryC');
          print(finalQueryC);
          print('finalQueryS');
          print(finalQueryS);
          print("finalQueryA");
          print(finalQueryA);

          var s12 = allOffers;
          finalMatch = [];
          for (int i = 0; i < allOffers.length; i++) {
            var offer = allOffers[i];
            var categories = offer.get("food_category").toString();
            print('categories');
            print(categories);
            var status = offer.get("food_status").toString();
            print('status');
            print(status);
            var quantity = offer.get("available_quantity").toString();

            if (categories.toLowerCase().contains(finalQueryC.toLowerCase()) &&
                status.toLowerCase().contains(finalQueryS.toLowerCase()) &&
                quantity.toLowerCase().contains(finalQueryA.toLowerCase())) {
              print('yeass match');
              finalMatch.add(offer);
            }
          }

          print('final match :');
          print(finalMatch);
        }
      }
    }

    var apply = false;
    Widget build(BuildContext context) {
      return AlertDialog(
        content: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          'Category',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.teal[200],
                                  ),
                        ),
                      ),
                    ),
                    Column(
                      //height: 25,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckboxListTile(
                          title: Text("Vegetables"), //    <-- label
                          value: Checked1Vegetables,
                          onChanged: (newValue) {
                            setState(() {
                              Checked1Vegetables = newValue!;
                            });
                            if (Checked1Vegetables) {
                              SelectedCategory.add('Vegetables');
                              print(SelectedCategory);
                            } else if (!Checked1Vegetables) {
                              SelectedCategory.remove('Vegetables');
                              print(SelectedCategory);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Fruits"), //    <-- label
                          value: Checked2Fruits,
                          onChanged: (newValue) {
                            setState(() {
                              Checked2Fruits = newValue!;
                            });
                            if (Checked2Fruits) {
                              SelectedCategory.add('Fruits');
                              print(SelectedCategory);
                            } else if (!Checked2Fruits) {
                              SelectedCategory.remove('Fruits');
                              print(SelectedCategory);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Meat"), //    <-- label
                          value: Checked3Meat,
                          onChanged: (newValue) {
                            setState(() {
                              Checked3Meat = newValue!;
                            });
                            if (Checked3Meat) {
                              SelectedCategory.add('Meat');
                              print(SelectedCategory);
                            } else if (!Checked3Meat) {
                              SelectedCategory.remove('Meat');
                              print(SelectedCategory);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Sea Food"), //    <-- label
                          value: Checked4Sea,
                          onChanged: (newValue) {
                            setState(() {
                              Checked4Sea = newValue!;
                            });
                            if (Checked4Sea) {
                              SelectedCategory.add('Sea Food');
                              print(SelectedCategory);
                            } else if (!Checked4Sea) {
                              SelectedCategory.remove('Sea Food');
                              print(SelectedCategory);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Bread"), //    <-- label
                          value: Checked5Bread,
                          onChanged: (newValue) {
                            setState(() {
                              Checked5Bread = newValue!;
                            });
                            if (Checked5Bread) {
                              SelectedCategory.add('Bread');
                              print(SelectedCategory);
                            } else if (!Checked5Bread) {
                              SelectedCategory.remove('Bread');
                              print(SelectedCategory);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Legumes"), //    <-- label
                          value: Checked6Legumes,
                          onChanged: (newValue) {
                            setState(() {
                              Checked6Legumes = newValue!;
                            });
                            if (Checked6Legumes) {
                              SelectedCategory.add('Legumes');
                              print(SelectedCategory);
                            } else if (!Checked6Legumes) {
                              SelectedCategory.remove('Legumes');
                              print(SelectedCategory);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Nuts and Seeds"), //    <-- label
                          value: Checked7Nuts,
                          onChanged: (newValue) {
                            setState(() {
                              Checked7Nuts = newValue!;
                            });
                            if (Checked7Nuts) {
                              SelectedCategory.add('Nuts and Seeds');
                              print(SelectedCategory);
                            } else if (!Checked7Nuts) {
                              SelectedCategory.remove('Nuts and Seeds');
                              print(SelectedCategory);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Candy"), //    <-- label
                          value: Checked8Candy,
                          onChanged: (newValue) {
                            setState(() {
                              Checked8Candy = newValue!;
                            });
                            if (Checked8Candy) {
                              SelectedCategory.add('Candy');
                              print(SelectedCategory);
                            } else if (!Checked8Candy) {
                              SelectedCategory.remove('Candy');
                              print(SelectedCategory);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("Dairy"), //    <-- label
                          value: Checked8Dairy,
                          onChanged: (newValue) {
                            setState(() {
                              Checked8Dairy = newValue!;
                            });
                            if (Checked8Dairy) {
                              SelectedCategory.add('Dairy');
                              print(SelectedCategory);
                            } else if (!Checked8Dairy) {
                              SelectedCategory.remove('Dairy');
                              print(SelectedCategory);
                            }
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                        CheckboxListTile(
                          title: Text("All"), //    <-- label
                          value: Checked9,
                          onChanged: (newValue) {
                            setState(() {
                              Checked9 = newValue!;
                            });
                          },
                          activeColor: Colors.tealAccent[200],
                          checkColor: Colors.black87,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          'Status',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.teal[200],
                                  ),
                        ),
                      ),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CheckboxListTile(
                            title: Text("Frozen"), //    <-- label
                            value: Checked1Frozen,
                            onChanged: (newValue) {
                              setState(() {
                                Checked1Frozen = newValue!;
                              });
                              if (Checked1Frozen) {
                                SelectedStatus.add('Frozen');
                                print(SelectedStatus);
                              } else if (!Checked1Frozen) {
                                SelectedStatus.remove('Frozen');
                                print(SelectedStatus);
                              }
                            },
                            activeColor: Colors.tealAccent[200],
                            checkColor: Colors.black87,
                          ),
                          CheckboxListTile(
                            title: Text("Cooked"), //    <-- label
                            value: Checked2Cooked,
                            onChanged: (newValue) {
                              setState(() {
                                Checked2Cooked = newValue!;
                              });
                              if (Checked2Cooked) {
                                SelectedStatus.add('Cooked');
                                print(SelectedStatus);
                              } else if (!Checked2Cooked) {
                                SelectedStatus.remove('Cooked');
                                print(SelectedStatus);
                              }
                            },
                            activeColor: Colors.tealAccent[200],
                            checkColor: Colors.black87,
                          ),
                          CheckboxListTile(
                            title: Text("Canned"), //    <-- label
                            value: Checked3Canned,
                            onChanged: (newValue) {
                              setState(() {
                                Checked3Canned = newValue!;
                              });
                              if (Checked3Canned) {
                                SelectedStatus.add('Canned');
                                print(SelectedStatus);
                              } else if (!Checked3Canned) {
                                SelectedStatus.remove('Canned');
                                print(SelectedStatus);
                              }
                            },
                            activeColor: Colors.tealAccent[200],
                            checkColor: Colors.black87,
                          ),
                          CheckboxListTile(
                            title: Text("Chilled"), //    <-- label
                            value: Checked4Chilled,
                            onChanged: (newValue) {
                              setState(() {
                                Checked4Chilled = newValue!;
                              });
                              if (Checked4Chilled) {
                                SelectedStatus.add('Chilled');
                                print(SelectedStatus);
                              } else if (!Checked4Chilled) {
                                SelectedStatus.remove('Chilled');
                                print(SelectedStatus);
                              }
                            },
                            activeColor: Colors.tealAccent[200],
                            checkColor: Colors.black87,
                          ),
                          CheckboxListTile(
                            title: Text("Fresh"), //    <-- label
                            value: Checked5Fresh,
                            onChanged: (newValue) {
                              setState(() {
                                Checked5Fresh = newValue!;
                              });
                              if (Checked5Fresh) {
                                SelectedStatus.add('Fresh');
                                print(SelectedStatus);
                              } else if (!Checked5Fresh) {
                                SelectedStatus.remove('Fresh');
                                print(SelectedStatus);
                              }
                            },
                            activeColor: Colors.tealAccent[200],
                            checkColor: Colors.black87,
                          ),
                          CheckboxListTile(
                            title: Text("Dried"), //    <-- label
                            value: Checked6Dried,
                            onChanged: (newValue) {
                              setState(() {
                                Checked6Dried = newValue!;
                              });
                              if (Checked6Dried) {
                                SelectedStatus.add('Dried');
                                print(SelectedStatus);
                              } else if (!Checked6Dried) {
                                SelectedStatus.remove('Dried');
                                print(SelectedStatus);
                              }
                            },
                            activeColor: Colors.tealAccent[200],
                            checkColor: Colors.black87,
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          'available quantity',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.teal[200],
                                  ),
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      title: Text("1-5"), //    <-- label
                      value: Checked1,
                      onChanged: (newValue) {
                        setState(() {
                          Checked1 = newValue!;
                        });
                        if (Checked1) {
                          SelectedQuantity.add('1-5');
                          print(SelectedQuantity);
                        } else if (!Checked1) {
                          SelectedQuantity.remove('1-5');
                          print(SelectedQuantity);
                        }
                      },
                      activeColor: Colors.tealAccent[200],
                      checkColor: Colors.black87,
                    ),
                    CheckboxListTile(
                      title: Text("6-10"), //    <-- label
                      value: Checked2,
                      onChanged: (newValue) {
                        setState(() {
                          Checked2 = newValue!;
                        });
                        if (Checked2) {
                          SelectedQuantity.add('6-10');
                          print(SelectedQuantity);
                        } else if (!Checked2) {
                          SelectedQuantity.remove('6-10');
                          print(SelectedQuantity);
                        }
                      },
                      activeColor: Colors.tealAccent[200],
                      checkColor: Colors.black87,
                    ),
                    CheckboxListTile(
                      title: Text("11-20"), //    <-- label
                      value: Checked3,
                      onChanged: (newValue) {
                        setState(() {
                          Checked3 = newValue!;
                        });
                        if (Checked3) {
                          SelectedQuantity.add('11-20');
                          print(SelectedQuantity);
                        } else if (!Checked3) {
                          SelectedQuantity.remove('11-20');
                          print(SelectedQuantity);
                        }
                      },
                      activeColor: Colors.tealAccent[200],
                      checkColor: Colors.black87,
                    ),
                    CheckboxListTile(
                      title: Text("21-30"), //    <-- label
                      value: Checked4,
                      onChanged: (newValue) {
                        setState(() {
                          Checked4 = newValue!;
                        });
                        if (Checked4) {
                          SelectedQuantity.add('21-30');
                          print(SelectedQuantity);
                        } else if (!Checked4) {
                          SelectedQuantity.remove('21-30');
                          print(SelectedQuantity);
                        }
                      },
                      activeColor: Colors.tealAccent[200],
                      checkColor: Colors.black87,
                    ),
                    CheckboxListTile(
                      title: Text("31-40"), //    <-- label
                      value: Checked5,
                      onChanged: (newValue) {
                        setState(() {
                          Checked5 = newValue!;
                        });
                        if (Checked5) {
                          SelectedQuantity.add('31-40');
                          print(SelectedQuantity);
                        } else if (!Checked5) {
                          SelectedQuantity.remove('31-40');
                          print(SelectedQuantity);
                        }
                      },
                      activeColor: Colors.tealAccent[200],
                      checkColor: Colors.black87,
                    ),
                    CheckboxListTile(
                      title: Text("more than 40"), //    <-- label
                      value: Checked6,
                      onChanged: (newValue) {
                        setState(() {
                          Checked6 = newValue!;
                        });
                        if (Checked6) {
                          SelectedQuantity.add('more than 40');
                          print(SelectedQuantity);
                        } else if (!Checked6) {
                          SelectedQuantity.remove('more than 40');
                          print(SelectedQuantity);
                        }
                      },
                      activeColor: Colors.tealAccent[200],
                      checkColor: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    searchWithFilter(
                        SelectedCategory, SelectedStatus, SelectedQuantity);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListOffersPage3(
                              myArray: finalMatch,
                              myArray2S: matchS,
                              myArray2C: matchC,
                              myArray2A: matchA,
                              apply: true,
                              AllCategory: Checked9,
                              SelectCategory: selectCategory2,
                              selectstatus: selectStatus2,
                            )),
                  );
                  //String text = "Data that we want to pass. Can be anything.";
                  // Navigator.pop(context, match);
                },
                child: const Text('Apply')),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
