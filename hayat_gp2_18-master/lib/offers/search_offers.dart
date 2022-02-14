import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/cho_home.dart';
import 'package:hayat_gp2_18/database/sqlite.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/offers/publish_offer.dart';
import 'package:hayat_gp2_18/main.dart';

class ListOffersPage3 extends StatefulWidget {
  var myArray;
  var myArray2S;
  var myArray2C;

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
      this.SelectCategory})
      : super(key: key);
  @override
  _ListOffersPage3 createState() => _ListOffersPage3(myArray, apply,
      AllCategory, myArray2S, myArray2C, selectstatus, SelectCategory);
}

class _ListOffersPage3 extends State<ListOffersPage3> {
  var myArray;
  var apply;
  var AllCategory;
  var myArray2S;
  var myArray2C;
  var SelectCategory;
  var selectstatus;
  _ListOffersPage3(this.myArray, this.apply, this.AllCategory, this.myArray2S,
      this.myArray2C, this.selectstatus, this.SelectCategory);

  // late String searchText = searchController.text;
  late var allOffers = [];
  var items = [];

  TextEditingController searchController = new TextEditingController();
  late String Searchstring = "";

  @override
  void initState() {
    super.initState();
    var helper = DatabaseHelper.instance.Categorylist().then((value) {
      setState(() {
        allOffers = value;
        items = allOffers;
      });
      search('', apply, myArray);
    });
  }

  void search(String query, var applay, var myAr) async {
    print('apply: ');
    print(applay);
    print('my filters:');
    print(myAr);

    var s = allOffers;
    if (query.isNotEmpty) {
      var match = [];
      s.forEach((element) {
        var offer = Offers.fromMap(element);
        var categories = offer.fCategory.split(' ').toString();
        var status = offer.fStatus.split(' ').toString();
        if (categories.toLowerCase().contains(query.toLowerCase()) ||
            status.toLowerCase().contains(query.toLowerCase())) {
          match.add(element);
        }
      });
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
        items = myAr;
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
                context, MaterialPageRoute(builder: (context) => HomeC()));
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
                        Offers offer = Offers.fromMap(items[i]);
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(
                                'Food Category:${offer.fCategory}\n\nFood Status:${offer.fStatus}\n\nEXP:${offer.eDate}\n'),
                            subtitle: Text('Available Quantity' + offer.aq),
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
  late var allOffers = [];
  var items = [];
  var matchC = [];
  var matchS = [];
  var finalMatch = [];
  bool selectStatus2 = false;
  bool selectCategory2 = false;

  @override
  void initState() {
    super.initState();
    //return all offers

    var helper = DatabaseHelper.instance.Categorylist().then((value) {
      setState(() {
        allOffers = value;
        items = allOffers;
      });
    });
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
        s.forEach((element) {
          var offer = Offers.fromMap(element);
          var categories = offer.fCategory.toString();
          if (categories.toLowerCase().contains(query.toLowerCase())) {
            matchC.add(element);
          }
        });

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
        s.forEach((element) {
          var offer = Offers.fromMap(element);
          var status = offer.fStatus.toString();
          var categories = offer.fCategory.toString();

          if (status.toLowerCase().contains(query2.toLowerCase())) {
            matchS.add(element);
          }
        });
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

        print('queryyyyyyy4');
        print(query4);
        print('queryyyyyyy5');
        print(query5);

        var s12 = allOffers;

        s12.forEach((element) {
          var offer = Offers.fromMap(element);
          var categories = offer.fCategory.toLowerCase().toString();
          var status = offer.fStatus.toLowerCase().toString();
          if (categories.contains(finalQueryC.toLowerCase()) &&
              status.contains(finalQueryS.toLowerCase())) {
            finalMatch.add(element);
          }
        });
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
